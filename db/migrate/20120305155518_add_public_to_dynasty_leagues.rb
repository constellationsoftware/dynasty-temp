class AddPublicToDynastyLeagues < ActiveRecord::Migration
    def up
        add_column :dynasty_leagues, :public, :boolean, :default => true
    end

    def down
        remove_column :dynasty_leagues, :public
    end
end
