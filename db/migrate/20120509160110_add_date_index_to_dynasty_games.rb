class AddDateIndexToDynastyGames < ActiveRecord::Migration
    def up
        add_index :dynasty_games, :date
    end

    def down
        remove_index :dynasty_games, :date
    end
end
