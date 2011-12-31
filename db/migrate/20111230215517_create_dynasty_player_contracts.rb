class CreateDynastyPlayerContracts < ActiveRecord::Migration
  def change
    create_table :dynasty_player_contracts do |t|

      t.timestamps
    end
  end
end
