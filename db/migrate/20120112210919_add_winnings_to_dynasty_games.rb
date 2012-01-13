class AddWinningsToDynastyGames < ActiveRecord::Migration
  def change
    add_column :dynasty_games, :winnings, :integer
  end
end
