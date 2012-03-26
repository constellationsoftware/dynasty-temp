class ChangePlayerTeamHistories < ActiveRecord::Migration
    def up
        rename_table :dynasty_player_team_histories, :dynasty_player_team_snapshots

        remove_column :dynasty_player_team_snapshots, :depth
        remove_column :dynasty_player_team_snapshots, :position_id
        remove_column :dynasty_player_team_snapshots, :league_id
        remove_column :dynasty_player_team_snapshots, :week

        rename_column :dynasty_player_team_snapshots, :user_team_id, :team_id

        add_column :dynasty_player_team_snapshots, :event_id, :integer
        add_column :dynasty_player_team_snapshots, :event_type, :string
        add_column :dynasty_player_team_snapshots, :lineup_id, :integer

        add_index :dynasty_player_team_snapshots, [ :player_id, :team_id, :event_id, :event_type ], :name => 'index_dynasty_player_team_snapshots_on_all'
    end

    def down
        remove_index :dynasty_player_team_snapshots, [ :player_id, :team_id, :event_id, :event_type ], :name => 'index_dynasty_player_team_snapshots_on_all'

        remove_column :dynasty_player_team_snapshots, :event_id
        remove_column :dynasty_player_team_snapshots, :event_type
        remove_column :dynasty_player_team_snapshots, :lineup_id

        rename_column :dynasty_player_team_snapshots, :team_id, :user_team_id

        add_column :dynasty_player_team_snapshots, :depth, :integer
        add_column :dynasty_player_team_snapshots, :position_id, :integer
        add_column :dynasty_player_team_snapshots, :league_id, :integer
        add_column :dynasty_player_team_snapshots, :week, :integer

        rename_table :dynasty_player_team_snapshots, :dynasty_player_team_histories
    end
end
