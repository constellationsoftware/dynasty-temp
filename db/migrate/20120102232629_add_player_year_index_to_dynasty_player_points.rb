class AddPlayerYearIndexToDynastyPlayerPoints < ActiveRecord::Migration
  def change
    add_index(:dynasty_player_points, [:player_id, :year], { :unique => true })
  end
end
