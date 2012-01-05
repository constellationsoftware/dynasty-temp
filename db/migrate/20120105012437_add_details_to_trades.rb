class AddDetailsToTrades < ActiveRecord::Migration
  def change
    add_column :dynasty_trades, :offered_player_id, :integer
    add_column :dynasty_trades, :requested_player_id, :integer
    add_column :dynasty_trades, :offered_cash, :integer
    add_column :dynasty_trades, :requested_cash, :integer
    add_column :dynasty_trades, :offered_picks, :string
    add_column :dynasty_trades, :requested_picks, :string

  end
end
