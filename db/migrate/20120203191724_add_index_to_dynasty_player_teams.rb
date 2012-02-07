class AddIndexToDynastyPlayerTeams < ActiveRecord::Migration
    def change
        add_index :dynasty_player_teams,
            [ :player_id, :depth, :user_team_id, :current ],
            { :name => 'index_dynasty_player_teams_roster_api' }
    end
end
