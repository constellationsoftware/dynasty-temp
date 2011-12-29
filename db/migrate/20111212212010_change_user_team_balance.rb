class ChangeUserTeamBalance < ActiveRecord::Migration
  def up
    change_column :user_team_balances, :balance_cents, :bigint
  end

  def down
    change_column :user_team_balances, :balance_cents, :int
  end
end
