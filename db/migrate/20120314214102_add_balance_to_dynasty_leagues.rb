class AddBalanceToDynastyLeagues < ActiveRecord::Migration
    def up
        add_column :dynasty_leagues, :balance_cents, :integer, :default => 0, :limit => 8
    end

    def down
        remove_column :dynasty_leagues, :balance_cents
    end
end
