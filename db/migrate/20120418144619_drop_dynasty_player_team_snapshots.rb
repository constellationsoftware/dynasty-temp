class DropDynastyPlayerTeamSnapshots < ActiveRecord::Migration
    def change
        drop_table :dynasty_player_team_snapshots
    end
end
