class RemoveManagerIdFromDynastyLeagues < ActiveRecord::Migration
    def up
        remove_column :dynasty_leagues, :manager_id
    end

    def down
        add_column :dynasty_leagues, :manager_id, :integer
    end
end
