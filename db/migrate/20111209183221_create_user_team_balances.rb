class CreateUserTeamBalances < ActiveRecord::Migration
  def change
    create_table :user_team_balances do |t|
      t.integer :balance_cents, :null => false, :default => 0
      t.integer :user_team_id, :null => false

      t.timestamps
    end
  end
end
