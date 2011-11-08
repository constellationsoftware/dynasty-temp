class RemoveBackupPicksTable < ActiveRecord::Migration
  def up
  	drop_table :backup_picks
  end

  def down
  	# nothing to do here
  end
end
