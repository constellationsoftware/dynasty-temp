class AddIndexesToDynastyGames < ActiveRecord::Migration
    def change
        add_index :dynasty_games, :team_id
        add_index :dynasty_games, :week
        add_index :dynasty_games, :points
    end
end
