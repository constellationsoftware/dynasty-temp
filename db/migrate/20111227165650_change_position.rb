class ChangePosition < ActiveRecord::Migration
  def change
    add_column :positions, :position_group_id, :integer
    add_index :positions, :position_group_id
  end
end
