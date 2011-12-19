class DropPicks < ActiveRecord::Migration
  def up
  	drop_table :picks
  end

  def down
  	# nothing to do
  end
end
