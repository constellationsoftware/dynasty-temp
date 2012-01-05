class AddIndexesToDynastyPlayerPoints < ActiveRecord::Migration
  def change
    add_index :dynasty_player_points, :points
    add_index :dynasty_player_points, :defensive_points
    add_index :dynasty_player_points, :fumbles_points
    add_index :dynasty_player_points, :passing_points
    add_index :dynasty_player_points, :rushing_points
    add_index :dynasty_player_points, :sacks_against_points
    add_index :dynasty_player_points, :scoring_points
    add_index :dynasty_player_points, :special_teams_points
    add_index :dynasty_player_points, :games_played
  end
end
