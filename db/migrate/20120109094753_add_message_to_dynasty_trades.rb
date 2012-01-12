class AddMessageToDynastyTrades < ActiveRecord::Migration
    def change
        add_column :dynasty_trades, :message, :text
    end
end
