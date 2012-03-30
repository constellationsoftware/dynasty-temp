class AddEventIdToDynastyGames < ActiveRecord::Migration
    def up
        add_column :dynasty_games, :event_id, :integer
        add_column :dynasty_games, :event_type, :string
        add_index :dynasty_games, [ :league_id, :event_id, :event_type ]
    end

    def down
        remove_index :dynasty_games, [ :league_id, :event_id, :event_type ]
        remove_column :dynasty_games, :event_type, :string
        remove_column :dynasty_games, :event_id
    end
end
