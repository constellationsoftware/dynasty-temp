class PlayerTeamRecord < ActiveRecord::Base
    set_table_name 'dynasty_player_teams'
    belongs_to :player
    belongs_to :position
    belongs_to :user_team
    belongs_to :team, :class_name => 'UserTeam', :foreign_key => :user_team_id
    has_one :user_team_lineup
    belongs_to :league

    attr_accessible :name, :position

    def name
        self.player.name.full_name
    end

    scope :qb, where(:position_id => 1)
    scope :wr, where(:position_id => 2)
    scope :rb, where(:position_id => 3)
    scope :te, where(:position_id => 4)
    scope :k, where(:position_id => 14)


    scope :on_waiver_wire, where(:waiver => 1)

    def self.set_all_positions
        PlayerTeamRecord.all.each do |ptr|
            ptr.position_id = ptr.player.andand.position.id
            ptr.save
        end
    end


    ## TODO: Make this not suck.
    def self.match_picks(draft_id)
        picks = Draft.find(draft_id).picks
        picks.each do |pick|
            ptr = PlayerTeamRecord.new
            ptr.current = TRUE
            ptr.player_id = pick.player_id
            ptr.details = "Drafted in round #{pick.round} at #{pick.picked_at} by #{pick.team.name}"
            ptr.user_team_id = pick.team_id
            ptr.league_id = UserTeam.find(pick.team_id).league.id
            ptr.added_at = pick.picked_at
            ptr.depth = 0
            ptr.position_id = Player.find(pick.player_id).position.id
            ptr.save
        end
    end
end
