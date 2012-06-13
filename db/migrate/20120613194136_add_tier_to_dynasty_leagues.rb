class AddTierToDynastyLeagues < ActiveRecord::Migration
    def up
        add_column :dynasty_leagues, :tier, :string
    end

    def down
        remove_column :dynasty_leagues, :tier
    end
end
