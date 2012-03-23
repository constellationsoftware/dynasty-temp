class CreateFedAccounts < ActiveRecord::Migration
  def change
    create_table :fed_accounts do |t|

      t.timestamps
    end
  end
end
