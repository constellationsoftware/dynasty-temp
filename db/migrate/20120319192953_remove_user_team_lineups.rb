class RemoveUserTeamLineups < ActiveRecord::Migration
    def change
        drop_table :user_team_lineups
    end
end
