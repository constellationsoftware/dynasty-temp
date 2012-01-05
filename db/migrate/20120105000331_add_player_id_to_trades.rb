class AddPlayerIdToTrades < ActiveRecord::Migration
  def change
    add_column :dynasty_trades, :player_id, :integer
    add_column :dynasty_trades, :accepted, :boolean
    add_column :dynasty_trades, :open, :boolean
    add_column :dynasty_trades, :offered_at, :timestamp
    add_column :dynasty_trades, :accepted_at, :timestamp
    add_column :dynasty_trades, :denied_at, :timestamp
  end
end
