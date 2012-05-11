class AddPlayerIdToDynastyPlayerTeamPoints < ActiveRecord::Migration
    def up
        add_column :dynasty_player_team_points, :player_id, :integer
        remove_index :dynasty_player_team_points, :name => 'index_dynasty_player_team_points_on_all'
        add_index :dynasty_player_team_points, [ :team_id, :game_id, :player_id, :player_point_id, :lineup_id ], :name => 'index_dynasty_player_team_points_on_all'
    end

    def down
        remove_index :dynasty_player_team_points, :name => 'index_dynasty_player_team_points_on_all'
        remove_column :dynasty_player_team_points, :player_id, :integer
        add_index :dynasty_player_team_points, [ :team_id, :game_id, :player_point_id, :lineup_id ]
    end
end
