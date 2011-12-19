class ChangeDraftCurrentPickToCurrentPickId < ActiveRecord::Migration
  def up
  	rename_column :drafts, :current_pick, :current_pick_id
  end

  def down
  	rename_column :drafts, :current_pick_id, :current_pick
  end
end
