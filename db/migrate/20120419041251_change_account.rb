class ChangeAccount < ActiveRecord::Migration
  def up
    rename_column  :dynasty_accounts, :eventable_id, :event_id
    rename_column  :dynasty_accounts, :eventable_type, :event_type
  end

  def down
    rename_column :dynasty_accounts, :event_id, :eventable_id
    rename_column :dynasty_accounts, :event_type, :eventable_type
  end
end
