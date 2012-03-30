class RenameEventableToEventOnDynastyAccounts < ActiveRecord::Migration
    def up
        rename_column :dynasty_accounts, :eventable_type, :event_type
        rename_column :dynasty_accounts, :eventable_id, :event_id
    end

    def down
        rename_column :dynasty_accounts, :event_type, :eventable_type
        rename_column :dynasty_accounts, :event_id, :eventable_id
    end
end
