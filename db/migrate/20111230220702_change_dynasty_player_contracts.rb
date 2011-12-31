class ChangeDynastyPlayerContracts < ActiveRecord::Migration
  def up
    add_column :dynasty_player_contracts, :person_id, :integer
    add_column :dynasty_player_contracts, :amount, :integer
    add_column :dynasty_player_contracts, :length, :integer
    add_column :dynasty_player_contracts, :end_year, :integer


  end

  def down
  end
end
