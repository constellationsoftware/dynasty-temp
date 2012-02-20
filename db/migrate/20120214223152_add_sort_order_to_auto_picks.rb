class AddSortOrderToAutoPicks < ActiveRecord::Migration
  def change
    add_column :auto_picks, :sort_order, :integer

  end
end
