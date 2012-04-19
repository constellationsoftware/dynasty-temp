# == Schema Information
#
# Table name: persons
#
#  id                        :integer(4)      not null, primary key
#  person_key                :string(100)     not null
#  publisher_id              :integer(4)      not null
#  gender                    :string(20)
#  birth_date                :string(30)
#  death_date                :string(30)
#  final_resting_location_id :integer(4)
#  birth_location_id         :integer(4)
#  hometown_location_id      :integer(4)
#  residence_location_id     :integer(4)
#  death_location_id         :integer(4)
#

class Player < ActiveRecord::Base
    self.table_name = 'persons'

    POSITION_QUANTITIES = [{
        # BENCH
        :o => { # offense
            :qb => 1,
            :rb => 1,
            :wr => 1,
            :te => 1
        },
        :d => {} # defense
    }, {
        # STARTERS
        :o => { # offense
            :qb => 1,
            :rb => 2,
            :wr => 2,
            :te => 1,
            :k => 1
        },
        :d => { #defense
            :dl => 3,
            :lb => 2,
            :db => 2
        }
    }]
    FREE_SLOTS = [
        { :o => 7, :d => 6 },
        { :o => 8, :d => 7 }
    ]

    #
    # NOTE about flex positions:
    # They are only defined for offensive positions since defensive
    # positions after requirements are SUGGESTED to be filled with equal distribution,
    # the user will end up with a diversified bench unless they choose not to. That and
    # all defensive positions are eligible flex positions.
    #
    FLEX_POSITIONS = [ :rb, :wr, :te ]

    has_one  :name,
             :class_name => 'DisplayName',
             :foreign_key => 'entity_id',
             :conditions => { :entity_type => 'persons' }
    has_one  :score, :class_name => 'PersonScore'
    has_one  :position_link, :class_name => 'PlayerPosition'
    has_one  :player_position
    has_one  :position, :through => :player_position
    has_many :player_teams
    has_many :teams, :through => :player_teams
    has_many :leagues, :through => :teams
    has_many :picks
    has_many :favorites
    has_many :all_points, :class_name => 'PlayerPoint'
    has_one  :points,
        :class_name => 'PlayerPoint',
        :conditions => proc{ { :year => Season.current.year } }
    has_many :event_points, :class_name => 'PlayerEventPoint', :foreign_key => 'player_id'
    has_many :events, :through => :event_points
    has_one  :contract, :foreign_key => 'person_id'



    def contract_depth
        self.contract.depth
    end

    def real_team
      SportsDb::Team.find(self.current_position.membership_id)
    end

    def amount
        self.contract.amount
    end

    def self.current
      with_points_from_season(2011)
    end

    def fname
      self.display_name.last_with_first_initial
    end


    def self.research
      current.with_contract.includes(:contract, :real_team, :fname, :display_name, :position, :real_team)
    end
    #
    # SCOPES
    #
    scope :roster, lambda { |team|
        joins{ player_teams }.where{ player_teams.team_id == my{ team.id } }
    }

    scope :drafted, lambda { |drafted_league|
        joins{ player_teams.team }.where { player_teams.team.league_id == my{ drafted_league.id } }
    }
    scope :with_contract, joins { contract }.includes { contract }
    scope :with_points, joins{ points }.includes{ points }
    scope :with_all_points, joins{ all_points }.includes{ all_points }
    scope :with_points_from_season, lambda { |season = 'last'|
        if season.is_a? String
            current_year = Season.current.year
            case season
                when 'current'
                    season = current_year
                else # last season
                    season = current_year - 1
            end
        end
        with_points.where { points.year == my{ season } }
    }
    # filter out players that have been picked already in this draft
    scope :available, lambda { |l_id|
        subquery = Team.select{ player_teams.player_id }
            .joins{ player_teams }
            .where{ (league_id == my{ l_id }) & (player_teams.player_id != nil) }
        where{ id.not_in(subquery) }
    }
    scope :with_name, joins{ name }.includes{ name }
    scope :with_position, joins{ position }.includes{ position }
    scope :by_name, lambda { |value|
        query = order{[
            isnull(name.full_name),
            isnull(name.last_name),
            isnull(name.first_name),
            name.last_name,
            name.first_name
        ]}
        query = query.where{ name.full_name.like "%#{sanitize(value)}%" } unless value.nil?
        return query
    }
    scope :with_favorites, lambda{ |team|
        self.reflect_on_association(:favorites).options[:conditions] = "#{Favorite.table_name}.team_id = #{team.id}"
        joins{ favorites.outer }.includes{ favorites }
    }

    scope :recommended, lambda{ |team_id, positions = nil|
        positions ||= Lineup.with_positions.empty(team_id).order{ id }.first
        position_ids = case positions
            when Position;  [ positions.id ]
            when Fixnum;    [ positions ]
            when Lineup;    positions.positions.collect{ |p| p.id }
        end

        joins{[ position, points ]}
            .where{ position.id >> (position_ids) }
            .order{ points.points.desc }
    }

    ##
    # This scope filters out positions on the starting lineup that have been
    # filled. Once a user has filled their starting lineup, all positions
    # are available again.
    #
    # If you pass in an array of whitelisted positions, they won't be calculated
    #
    scope :filter_positions, lambda { |team = nil, filter = nil|
        recommended_position = nil
        if filter
            recommended_position = Position.find_by_abbreviation(filter).id
        elsif team
            [:o, :d].each do |designation|
                break unless recommended_position.nil?
                [1, 0].each do |depth|
                    max_counts = POSITION_QUANTITIES[depth][designation]

                    # count how many picks have been made by position
                    position_counts = self.get_position_counts(team, depth, designation)

                    # remove "filled" positions
                    vacant_positions = position_counts.reject do |position|
                        max_count ||= max_counts[position.abbreviation.to_sym]
                        max_count.nil? || position.count >= max_count
                    end

                    # if we have some vacant positions, the one we want is the first
                    unless vacant_positions.empty?
                        recommended_position = vacant_positions.first.id
                        puts "Found open position (#{recommended_position}) at designation: #{designation}, depth: #{depth}"
                        break
                    end

                    # special case for flex positions:
                    #   the defined starting slots are filled but starter count is still less than specified in FREE_SLOTS
                    # special case for remaining bench positions to give them an even distribution after minimum requirements have been met

                    counts ||= position_counts.collect{ |x| x.count if x.designation == designation }.compact
                    player_sum = counts.empty? ? 0 : counts.reduce(:+)
                    # if there are any slots open for defensive bench positions
                    if player_sum < FREE_SLOTS[depth][designation]
                        if depth === 1
                            recommended_position = FLEX_POSITIONS
                            break
                        elsif depth === 0
                            # grab the highest-ordered defensive position with the lowest count
                            position = Position.find_by_sql("
                                SELECT p.id
                                FROM dynasty_positions p
                                JOIN (
                                    SELECT position_id, COUNT(id) AS count
                                    FROM dynasty_player_teams
                                    WHERE current = 1 AND team_id = #{sanitize(team.id)} AND depth = #{depth}
                                    GROUP BY position_id
                                ) AS pt
                                ON p.id = pt.position_id
                                WHERE p.designation = '#{designation}'
                                ORDER BY pt.count, p.sort_order
                                LIMIT 1
                            ")
                            recommended_position ||= position.first.id unless position.empty?
                        end
                    end
                end
            end
        end
        puts "Recommended position: #{recommended_position.inspect}"
        current_year = Season.current.year
        result = joins{ [points, position] }.includes{ [points, position] }
            .where{ points.year == my{ current_year }}
        if !(recommended_position.nil?)
            if recommended_position.is_a? Array
                result = result.where{ position.abbreviation >> recommended_position }
            else
                result = result.where{ position.id == my{ recommended_position } }
            end
        else
            result = result.where{ position.designation == :d }
        end
        result
    }

    scope :filter_by_name, lambda{ |player_name|
        where{ (name.last_name =~ "#{player_name}%") | (name.first_name =~ "#{player_name}%") | (name.full_name =~ "#{player_name}%") }
    }

    def points_for_week(week = 1)
        week_end = Clock.first_week.advance :weeks => week
        week_start = week_end.advance :weeks => -1
        PlayerEventPoint.joins{[event, player]}
            .where{player.id == my{self.id}}
            .where('events.start_date_time BETWEEN ? AND ?', week_start, week_end)
            .first
        #.where{player.player_teams.depth == 1}
    end

    def full_name; name.full_name end
    def last_name_first; (name.first_name && name.last_name) ? "#{name.last_name}, #{name.first_name}" : full_name end

    def points_last_season
        PlayerPoint.select(:points).where(:year => Season.current).find_by_player_id(self.id).andand.points
    end

    def points_per_dollar
        (self.points_last_season.to_f / self.contract.amount.to_f) * 1000000
    end

    def flatten
        obj = {
            :id => id,
            :full_name => name.full_name,
            :first_name => name.first_name,
            :last_name => name.last_name,
            :position => (position.nil?) ? '' : position.abbreviation.upcase,
            :contract_amount => contract.amount,
            :bye_week => contract.bye_week
        }

        if respond_to?('points') and points.length > 0
            obj = obj.merge({
                :points => points.first.points,
                :defensive_points => points.first.defensive_points,
                :fumbles_points => points.first.fumbles_points,
                :passing_points => points.first.passing_points,
                :rushing_points => points.first.rushing_points,
                :sacks_against_points => points.first.sacks_against_points,
                :scoring_points => points.first.scoring_points,
                :special_teams_points => points.first.special_teams_points,
                :games_played => points.first.games_played
            })
        end
        return obj
    end

    def self.get_position_counts(team, depth, designation)
        team = team.id if team.is_a? Team
        Position.find_by_sql("
            SELECT id, abbreviation, designation, (
                SELECT COUNT(*)
                FROM dynasty_player_teams pt
                JOIN dynasty_player_positions pp
                ON pt.player_id = pp.player_id
                WHERE team_id = #{sanitize(team)}
                    AND pp.position_id = pos.id
                    AND depth = #{depth}
                    AND designation = '#{designation}'
            ) AS count
            FROM dynasty_positions pos
            ORDER BY sort_order
        ")
    end

    def self.position_quantities; POSITION_QUANTITIES end
    def self.free_slots; FREE_SLOTS end
    def self.flex_positions; FLEX_POSITIONS end

    def points_this_season
        season = Season.current
        PlayerEventPoint.joins{ event }
            .where{ player_id == my{ self.id } }
            .where{ event.start_date_time >> (season.start_date.at_midnight..Clock.first.time) }
            .select{ sum(points).as('points') }
            .first
            .points or 0
    end
end
