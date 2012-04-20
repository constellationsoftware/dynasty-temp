class ChangeCurrentPickIdOnDynastyDrafts < ActiveRecord::Migration
    def up
        rename_column :dynasty_drafts, :current_pick_id, :pick_id
        rename_column :dynasty_drafts, :status, :state
        add_index :dynasty_drafts, :state
        change_column :dynasty_drafts, :league_id, :integer, :null => true
    end
    def down
        change_column :dynasty_drafts, :league_id, :integer, :null => false
        remove_index :dynasty_drafts, :state
        rename_column :dynasty_drafts, :state, :status
        rename_column :dynasty_drafts, :pick_id, :current_pick_id
        add_index :dynasty_drafts, :status
    end
end
