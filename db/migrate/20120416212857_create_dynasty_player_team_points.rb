class CreateDynastyPlayerTeamPoints < ActiveRecord::Migration
    def up
        create_table :dynasty_player_team_points do |t|
            t.integer       :team_id
            t.integer       :game_id
            t.integer       :lineup_id
            t.integer       :player_point_id
            t.timestamps
        end

        add_index :dynasty_player_team_points, [ :team_id, :game_id, :player_point_id, :lineup_id ], :name => 'index_dynasty_player_team_points_on_all'
    end

    def down
        drop_table :dynasty_player_team_points
    end
end
