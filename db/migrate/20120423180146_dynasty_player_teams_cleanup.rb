class DynastyPlayerTeamsCleanup < ActiveRecord::Migration
    def change
        remove_column :dynasty_player_teams, :current
        remove_column :dynasty_player_teams, :depth
        remove_column :dynasty_player_teams, :added_at
        remove_column :dynasty_player_teams, :removed_at
        remove_column :dynasty_player_teams, :details
        remove_column :dynasty_player_teams, :position_id
        remove_column :dynasty_player_teams, :waiver
        remove_column :dynasty_player_teams, :waiver_team_id

        remove_index :dynasty_player_teams, :name => "index_dynasty_player_teams_roster_api"
        remove_index :dynasty_player_teams, :name => "index_position_counts_by_team"
        remove_index :dynasty_player_teams, :name => "index_player_teams_league_user_player"

        add_index :dynasty_player_teams, [ :player_id, :team_id, :lineup_id ], :name => 'index_dynasty_player_teams_on_player_and_team_and_lineup'
    end
end
