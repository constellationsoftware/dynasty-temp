class AddTransactionDateTimeToDynastyAccounts < ActiveRecord::Migration
    def up
        add_column :dynasty_accounts, :transaction_datetime, :datetime, :null => false
        add_index :dynasty_accounts, :transaction_datetime
    end

    def down
        remove_column :dynasty_accounts, :transaction_datetime
    end
end
