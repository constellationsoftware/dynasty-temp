class RemoveNameFromPosition < ActiveRecord::Migration
  def up
    remove_column :positions, :name
  end

  def down
    add_column :positions, :name, :string
  end
end
