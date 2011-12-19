class RemoveRoundsTable < ActiveRecord::Migration
  def up
  	drop_table :rounds
  end

  def down
  	# nothing to do here
  end
end
