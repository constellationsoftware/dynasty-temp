class RemovePickIdFromDynastyDrafts < ActiveRecord::Migration
    def up
        remove_column :dynasty_drafts, :pick_id
    end

    def down
        add_column :dynasty_drafts, :pick_id, :integer
    end
end
