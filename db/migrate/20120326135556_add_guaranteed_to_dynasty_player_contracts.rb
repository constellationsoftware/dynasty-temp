class AddGuaranteedToDynastyPlayerContracts < ActiveRecord::Migration
    def up
        add_column :dynasty_player_contracts, :guaranteed, :integer
    end

    def down
        remove_column :dynasty_player_contracts, :guaranteed
    end
end
