class AddByeWeekToDynastyPlayerContracts < ActiveRecord::Migration
  def change
    add_column :dynasty_player_contracts, :bye_week, :integer
  end
end
