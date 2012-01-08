class AddDefaultBalanceToDynastyLeagues < ActiveRecord::Migration
  def change
    add_column :dynasty_leagues, :default_balance_cents, :bigint, { :null => false, :default => 0 }
    add_column :dynasty_teams, :balance_cents, :bigint, { :null => false, :default => 0 }
    drop_table :dynasty_team_balances
    add_index :dynasty_teams, :balance_cents

    League.all.each { |league|
      league.default_balance = 75000000
      league.teams.each { |team|
        team.balance = 75000000
        team.save
      }
      league.save
    }
  end
end
