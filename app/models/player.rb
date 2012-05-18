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

    #has_one  :name, :class_name => 'PlayerName', :as => :entity, :identity => :persons
    has_one  :name,
                 :class_name => 'DisplayName',
                 :foreign_key => 'entity_id',
                 :conditions => { :entity_type => 'persons' }
    has_many :person_phases, :foreign_key => :person_id
    has_one  :score, :class_name => 'PersonScore'
    has_one  :position_link, :class_name => 'PlayerPosition'
    has_one  :player_position
    has_one  :position, :through => :player_position
    has_many :player_teams
    has_many :teams, :through => :player_teams
    has_many :waivers, :through => :player_teams
    has_many :leagues, :through => :teams
    has_many :picks
    has_many :favorites
    has_many :all_points, :class_name => 'PlayerPoint'
    has_one  :points,
        :class_name => 'PlayerPoint',
        :conditions => proc{ { :year => Season.current.year } },
        :order => 'points DESC'
    has_many :event_points, :class_name => 'PlayerEventPoint', :foreign_key => 'player_id'
    has_many :real_events, :through => :event_points, :class_name => 'Event'
    has_one  :contract, :foreign_key => 'person_id'
    has_one  :active_team_phase, :class_name => 'PersonPhase', :foreign_key => :person_id,
        :conditions => { :membership_type => 'teams', :phase_status => 'active' }
    has_one  :real_team, :through => :active_team_phase

    def all_leagues

    end



    def in_league


    end

    def on_team

    end



    def self.research
      current.with_contract.with_name.with_points_from_season(2011).includes(:contract, :name, :position, :points)
    end

    def contract_depth
        self.contract.depth
    end

   ## def team_short
   ##   location = self.real_team{:location-name}
   ##   @team_short = " #{self.real_team.nickname}"
   ## end

    def season_points
      self.all_points.all
    end

    def phase
      person_phases.current.first
    end



    def weight
      weight = phase.weight
      Quantity.new(weight, :lb)
    end

    def amount
        self.contract.amount
    end

    def self.current
      with_points_from_season(2011).with_position
    end

    def fname
      @fname = self.name.last_with_first_initial
    end



    #
    # SCOPES
    #
    scope :roster, lambda { |team|
        joins{ player_teams }.where{ player_teams.team_id == my{ team.id } }
    }

    scope :drafted, lambda { |lid|
        joins{ player_teams.team }.where { player_teams.team.league_id == my{ lid } }
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
        query
    }
    scope :with_favorites, lambda{ |tid|
        self.reflect_on_association(:favorites).options[:conditions] = "#{Favorite.table_name}.team_id = #{tid}"
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

    scope :filter_by_name, lambda{ |player_name|
        where{ (name.last_name =~ "#{player_name}%") | (name.first_name =~ "#{player_name}%") | (name.full_name =~ "#{player_name}%") }
    }
    scope :filter_by_position, lambda{ |p| where{ position.abbreviation =~ my{ p } } }
    scope :filter_by_team, lambda{ |t| where{ real_team.display_name.abbreviation == my{ t } } }

    def full_name; name.full_name end
    def last_name_first; (name.first_name && name.last_name) ? "#{name.last_name}, #{name.first_name}" : full_name end
    def first_initial_last; name.first_name.nil? ? name.last_name : "#{name.first_name.first}. #{name.last_name}" end

    def points_last_season
        PlayerPoint.select(:points).where(:year => 2011).find_by_player_id(self.id).andand.points
    end

    def points_per_dollar

        if self.points_last_season > 0
          ( self.contract.amount.to_f / self.points_last_season.to_f  ).to_i
        else
          "--"
        end

    end



    def points_this_season
        season = Season.current
        PlayerEventPoint.joins{ event }
            .where{ player_id == my{ self.id } }
            .where{ event.start_date_time >> (season.start_date.at_midnight..Clock.first.time) }
            .select{ sum(points).as('points') }
            .first
            .points or 0
    end

    def eligible_slots
        Lineup.by_position(self.player_position.position_id)
    end

    def eligible_slots_for(team)
        Lineup.empty(team.id).by_position(self.player_position.position_id)
    end
end
