class AddBalancesToDynastyAccounts < ActiveRecord::Migration
    def up
        add_column :dynasty_accounts, :receivable_balance_cents, :integer, :limit => 8
        add_column :dynasty_accounts, :payable_balance_cents, :integer, :limit => 8
    end

    def down
        remove_column :dynasty_accounts, :receivable_balance_cents
        remove_column :dynasty_accounts, :payable_balance_cents
    end
end
