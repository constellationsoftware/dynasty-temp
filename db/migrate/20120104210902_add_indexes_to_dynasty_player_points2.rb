class AddIndexesToDynastyPlayerPoints2 < ActiveRecord::Migration
  def change
    add_index :dynasty_player_points, [ :year, :points, :player_id ]
    add_index :dynasty_player_points, [ :year, :points ]
  end
end
