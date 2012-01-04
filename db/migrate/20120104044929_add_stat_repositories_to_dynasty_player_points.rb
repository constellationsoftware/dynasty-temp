class AddStatRepositoriesToDynastyPlayerPoints < ActiveRecord::Migration
  def change
    add_column :dynasty_player_points, :games_played, :integer, { :null => false, :default => 0 }
    add_column :dynasty_player_points, :defensive_points, :integer, { :null => false, :default => 0 }
    add_column :dynasty_player_points, :fumbles_points, :integer, { :null => false, :default => 0 }
    add_column :dynasty_player_points, :passing_points, :integer, { :null => false, :default => 0 }
    add_column :dynasty_player_points, :rushing_points, :integer, { :null => false, :default => 0 }
    add_column :dynasty_player_points, :sacks_against_points, :integer, { :null => false, :default => 0 }
    add_column :dynasty_player_points, :scoring_points, :integer, { :null => false, :default => 0 }
    add_column :dynasty_player_points, :special_teams_points, :integer, { :null => false, :default => 0 }
  end
end
