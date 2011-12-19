class RemovePickingOrdersTable < ActiveRecord::Migration
  def up
  	drop_table :picking_orders
  end

  def down
  	# nothing to do here
  end
end
