class AddDepthToDynastyPlayerContracts < ActiveRecord::Migration
  def change
    add_column :dynasty_player_contracts, :depth, :string
  end
end
