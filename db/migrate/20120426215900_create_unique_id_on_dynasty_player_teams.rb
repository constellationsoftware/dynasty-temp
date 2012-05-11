class CreateUniqueIdOnDynastyPlayerTeams < ActiveRecord::Migration
    def up
        add_index :dynasty_player_teams, [ :team_id, :lineup_id ], :unique => true
    end

    def down
        remove_index :dynasty_player_teams, [ :team_id, :lineup_id ]
    end
end
