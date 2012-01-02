class ChangePlayerPoints < ActiveRecord::Migration
  def change
    remove_column(:dynasty_player_points, :created_at)
    add_timestamps :dynasty_player_points
    rename_column(:dynasty_player_points, :score, :points)
    rename_column(:dynasty_player_points, :person_id, :player_id)
    add_index(:dynasty_player_points, :player_id)
  end
end
