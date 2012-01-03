class AddYearToDynastyPlayerPoints < ActiveRecord::Migration
  def change
    add_column :dynasty_player_points, :year, :integer, { :default => 2000, :null => false}
    add_index(:dynasty_player_points, :year)
  end
end
