class ChangeDynastyPlayerContracts < ActiveRecord::Migration
  def up
    create_table :dynasty_player_contracts do |t|

      t.timestamps
    end
    add_column :dynasty_player_contracts, :person_id, :integer
    add_column :dynasty_player_contracts, :amount, :integer
    add_column :dynasty_player_contracts, :length, :integer
    add_column :dynasty_player_contracts, :end_year, :integer
    add_column :dynasty_player_contracts, :summary, :string
    add_column :dynasty_player_contracts, :free_agent_year, :string

  end

  def down
  end
end
