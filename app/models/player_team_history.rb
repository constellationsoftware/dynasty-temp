class PlayerTeamHistory < ActiveRecord::Base
    self.table_name = 'dynasty_player_team_histories'
    belongs_to :player
    belongs_to :position
    belongs_to :user_team
    belongs_to :team, :class_name => 'UserTeam', :foreign_key => :user_team_id
    belongs_to :league

    attr_accessible :name, :position, :depth, :last_name


    def name
        self.player.name.full_name
    end

    def last_name
        self.player.name.last_name
    end
    scope :qb, where(:position_id => 1)
    scope :wr, where(:position_id => 2)
    scope :rb, where(:position_id => 3)
    scope :te, where(:position_id => 4)
    scope :k, where(:position_id => 14)

   def points_for_week(week)
       season_start = Date.new(2011, 9, 8).at_midnight
       week_start = season_start.advance :weeks => week -1
       week_end = season_start.advance :weeks => week

       total_points = self.player.event_points
       .joins{[event, player.team_link.team]}
       .where{player.team_link.team.id == my{ team.id }}
       .where{(event.start_date_time >= week_start) & (event.start_date_time < week_end)}
       .first

       total_points

   end

    #
    # Returns (current) records of players that share the same position
    #
    def players_in_position(position_depth = nil)
        query = self.class.where{(user_team_id == my{self.user_team_id}) & (position_id == my{self.position_id}) }
        query = query.where{depth == position_depth} unless position_depth.nil?
        query
    end
end
