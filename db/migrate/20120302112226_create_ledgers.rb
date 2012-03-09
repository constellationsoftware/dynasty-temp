class CreateLedgers < ActiveRecord::Migration
  def change
    create_table :ledgers do |t|
      t.text :description
      t.integer :amount
      t.integer :account

      t.timestamps
    end
  end
end
