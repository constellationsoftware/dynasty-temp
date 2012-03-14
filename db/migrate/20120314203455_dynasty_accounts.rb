class DynastyAccounts < ActiveRecord::Migration
    def up
        create_table :dynasty_accounts do |t|
            t.string        :type
            t.references    :payable, :polymorphic => true
            t.references    :receivable, :polymorphic => true
            t.references    :eventable, :polymorphic => true, :null => false
            t.integer       :amount_cents, :limit => 8, :null => false
            t.timestamps
        end
    end

    def down
        drop_table :dynasty_accounts
    end
end
