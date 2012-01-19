class AddFlexToDynastyPositions < ActiveRecord::Migration
  def change
    add_column :dynasty_positions, :flex, :integer, { :null => false, :default => 0 }
    change_column :dynasty_positions, :name, :string, :limit => 32
    change_column :dynasty_positions, :abbreviation, :string, :limit => 2
    change_column :dynasty_positions, :designation, :string, :limit => 1

    remove_index :dynasty_positions, :name => 'index_dynasty_positions_on_sort_id_des_abbr_name'
    remove_index :dynasty_positions, :name => 'index_dynasty_positions_on_abbr_id_des_name_sort'
    add_index :dynasty_positions, [ :sort_order, :id, :designation, :flex, :abbreviation, :name ], { :name => 'index_dynasty_positions_on_sort_id_des_abbr_name' }
    add_index :dynasty_positions, [ :abbreviation, :id, :designation, :flex, :name, :sort_order ], { :name => 'index_dynasty_positions_on_abbr_id_des_name_sort' }
    add_index :dynasty_positions, [ :flex, :designation, :id ]
  end
end
