class Player < ActiveRecord::Base
    set_table_name 'persons'
    POSITION_PRIORITIES = %w(QB WR RB TE C G T K)
    POSITION_QUANTITIES = {
        :qb => 1,
        :wr => 2,
        :rb => 2,
        :te => 1,
        :k => 1,
        :t => 2,
        :g => 2,
        :c => 1
    }
    default_scope joins(name).includes(name)

    has_one :name,
            :class_name => 'DisplayName',
            :foreign_key => 'entity_id',
            :conditions => {:entity_type => :persons}
    has_one :position_link, :class_name => 'PlayerPosition'
    has_one :position, :through => :position_link
    has_one :team_link, :class_name => 'PlayerTeamRecord'
    has_many :teams, :through => :team_link, :class_name => 'UserTeam'
    has_many :leagues, :through => :teams
    has_many :picks
    has_many :points, :class_name => 'PlayerPoint'
    has_many :event_points, :class_name => 'PlayerEventPoint', :foreign_key => 'player_id'
    has_many :events, :through => :event_points
    has_one :contract, :foreign_key => 'person_id'

    def contract_depth
        self.contract.depth
    end

    def amount
        self.contract.amount
    end

    def self.order_by_position_priority
        ret = "CASE"
        POSITION_PRIORITIES.each_with_index do |p, i|
            ret << " WHEN SUBSTRING(dynasty_positions.abbreviation, 1, 2) = '#{p}' THEN #{i}"
        end
        ret << " END ASC"
    end

    #
    # SCOPES
    #
    scope :roster, lambda { |team|
        joins{ picks.user }.where { picks.team_id == my { team.id } }
    }
    scope :with_contract, joins{ contract }.includes { contract }
    scope :with_points, joins(:points).includes(:points)
    scope :with_points_from_season do |season|
        if season.nil?
            season = 'last'
        end
        if season.is_a?(String)
            current_year = Season.maximum(:season_key).to_i
            case season
                when 'current'
                    season = current_year
                else # last season
                    season = current_year - 1
            end
        end
        self.with_points.where { points.year == "#{season}" }
    end

    # filter out players that have been picked already in this draft
    scope :available, lambda { |draft|
        #joins{picks.outer}.where{(picks.draft_id == nil) | (picks.draft_id.not_eq my{draft.id})}
        picks_subquery = Pick.select { distinct(player_id) }.where { (player_id != nil) & (draft_id == my { draft.id }) }
        where { id.not_in picks_subquery }
    }
    scope :by_position_priority, joins{ position }.where { substring(position.abbreviation, 1, 2) >> my { POSITION_PRIORITIES } }.order(order_by_position_priority)
    scope :by_name, lambda { |value|
        query = order{[
            isnull(name.full_name),
            isnull(name.last_name),
            isnull(name.first_name),
            name.last_name,
            name.first_name
        ]}
        query = query.where{ name.full_name.like "%#{value}%" } unless value.nil?
        return query
    }
    ##
    # This scope filters out positions on the starting lineup that have been
    # filled. Once a user has filled their starting lineup, all positions
    # are available again.
    #
    # If you pass in an array of whitelisted positions, they won't be calculated
    #
    scope :filter_positions do |team, filters|
        current_year = Season.order { season_key.desc }.first.season_key
        if !filters
            # count how many picks have been made by position
            position_counts = Position.find_by_sql("
            SELECT abbreviation AS abbr, (
                SELECT COUNT(*)
                FROM dynasty_draft_picks dp
                JOIN dynasty_player_positions pp
                ON dp.player_id = pp.player_id
                WHERE team_id = #{team.id} AND pp.position_id = pos.id
            ) AS count
            FROM dynasty_positions pos
            ")
            filters = position_counts.delete_if { |position_count|
                max = POSITION_QUANTITIES[position_count.abbr.to_sym]
                max.nil? or position_count.count >= max
            }.collect { |x| x.abbr }
        end

        if !!filters and filters.length > 0
            points_subquery = Player.select { id }.joins { points }.where { points.year == "#{current_year}" }
            points_subquery = points_subquery.where { position.abbreviation.like_any filters } if filters.length > 0
        end

        query = joins { [points, position] }.includes { [points, position] }.where { points.year == "#{current_year}" }
        query = query.where { id.in(points_subquery) } if !!points_subquery
        query
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
end
