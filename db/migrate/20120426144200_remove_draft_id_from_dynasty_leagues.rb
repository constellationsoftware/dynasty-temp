class RemoveDraftIdFromDynastyLeagues < ActiveRecord::Migration
    def up
        remove_column :dynasty_leagues, :draft_id
    end

    def down
        add_column :dynasty_leagues, :draft_id, :integer
    end
end
