class ChangeDynastyGames < ActiveRecord::Migration
  def change
    remove_column :dynasty_games, :away_team_id
    remove_column :dynasty_games, :date
    rename_column :dynasty_games, :home_team_id, :team_id
    add_column :dynasty_games, :points, :integer, { :null => false, :default => 0 }
  end
end
