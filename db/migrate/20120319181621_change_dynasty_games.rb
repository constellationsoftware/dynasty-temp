class ChangeDynastyGames < ActiveRecord::Migration
    def up
        change_column :dynasty_games, :home_team_score, :decimal, :precision => 4, :scale => 1
        change_column :dynasty_games, :away_team_score, :decimal, :precision => 4, :scale => 1
    end

    def down
        change_column :dynasty_games, :home_team_score, :decimal, :precision => 9, :scale => 5
        change_column :dynasty_games, :away_team_score, :decimal, :precision => 9, :scale => 5
    end
end
