class Player < ActiveRecord::Base
    set_table_name 'persons'

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
            :te => 2,
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

    has_one  :name,
             :class_name => 'DisplayName',
             :foreign_key => 'entity_id',
             :conditions => { :entity_type => 'persons' }
    has_one  :score, :class_name => 'PersonScore'
    has_one  :position_link, :class_name => 'PlayerPosition'
    has_one  :position, :through => :position_link
    has_one  :team_link, :class_name => 'PlayerTeamRecord'
    has_many :teams, :through => :team_link, :class_name => 'UserTeam'
    has_many :leagues, :through => :teams
    has_many :picks
    has_many :points, :class_name => 'PlayerPoint'
    has_many :event_points, :class_name => 'PlayerEventPoint', :foreign_key => 'player_id'
    has_many :events, :through => :event_points
    has_one  :contract, :foreign_key => 'person_id'

    def contract_depth
        self.contract.depth
    end

    def amount
        self.contract.amount
    end

    #
    # SCOPES
    #
    scope :roster, lambda { |team|
        joins { picks.user }.where { picks.team_id == my { team.id } }
    }
    scope :with_contract, joins { contract }.includes { contract }
    scope :with_points, joins { points }.includes { points }
    scope :with_points_from_season, lambda { |season = 'last'|
        if season.is_a? String
            current_year = Season.maximum(:season_key).to_i
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
    scope :available, lambda { |draft|
        #joins{picks.outer}.where{(picks.draft_id == nil) | (picks.draft_id.not_eq my{draft.id})}
        picks_subquery = Pick.select { distinct(player_id) }.where { (player_id != nil) & (draft_id == my { draft.id }) }
        where { id.not_in picks_subquery }
    }
    scope :with_name, joins{name}.includes{name}
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

                    # special case for remaining bench positions to give them an even distribution after requirements
                    if depth === 0
                        counts ||= position_counts.collect{ |x| x.count if x.designation == designation }.compact
                        player_sum = counts.empty? ? 0 : counts.reduce(:+)

                        # if there are any slots open for defensive bench positions
                        if player_sum < FREE_SLOTS[depth][designation]
                            # grab the highest-ordered offensive position with the lowest count
                            position = Position.find_by_sql("
                                SELECT p.id
                                FROM dynasty_positions p
                                JOIN (
                                    SELECT position_id, COUNT(id) AS count
                                    FROM dynasty_player_teams
                                    WHERE current = 1 AND user_team_id = #{sanitize(team.id)} AND depth = 0
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
        puts recommended_position.inspect

        current_year = Season.order { season_key.desc }.first.season_key
        result = joins{ [points, position] }.includes{ [points, position] }
            .where{ points.year == my{ current_year }}
        if !(recommended_position.nil?)
            result = result.where{ position.id == my{ recommended_position } }
        else
            result = result.where{ position.designation == :d }
        end
        result  
    }

    def points_for_week(week = 1)
        week_end = Clock.first_week.advance :weeks => week
        week_start = week_end.advance :weeks => -1
        PlayerEventPoint.joins{[event, player]}
            .where{player.id == my{self.id}}
            .where('events.start_date_time BETWEEN ? AND ?', week_start, week_end)
            .first
        #.where{player.team_link.depth == 1}
    end

    def full_name
        name.full_name
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

    def self.position_quantities
        POSITION_QUANTITIES
    end

    def self.free_slots
        FREE_SLOTS
    end

    def self.get_position_counts(team, depth, designation)
        Position.find_by_sql("
            SELECT id, abbreviation, designation, (
                SELECT COUNT(*)
                FROM dynasty_player_teams pt
                JOIN dynasty_player_positions pp
                ON pt.player_id = pp.player_id
                WHERE user_team_id = #{sanitize(team.id)}
                    AND pp.position_id = pos.id
                    AND depth = #{depth}
                    AND designation = '#{designation}'
            ) AS count
            FROM dynasty_positions pos
            ORDER BY sort_order
        ")
    end
end
