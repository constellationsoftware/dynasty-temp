class RemoveLeagueAndPlayerFromDynastyTrades < ActiveRecord::Migration
    def up
        remove_column :dynasty_trades, :league_id
        remove_column :dynasty_trades, :player_id
    end

    def down
        add_column :dynasty_trades, :league_id, :integer, :null => false
        add_column :dynasty_trades, :player_id, :integer
    end
end
