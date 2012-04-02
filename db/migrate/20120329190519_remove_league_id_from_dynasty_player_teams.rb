class RemoveLeagueIdFromDynastyPlayerTeams < ActiveRecord::Migration
    def up
        remove_column :dynasty_player_teams, :league_id
    end

    def down
        add_column :dynasty_player_teams, :league_id, :integer, :null => false
        add_index :dynasty_player_teams, [ :league_id, :user_team_id, :player_id ], :name => 'index_player_teams_league_user_player'
    end
end
