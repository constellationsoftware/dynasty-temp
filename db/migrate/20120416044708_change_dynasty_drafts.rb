class ChangeDynastyDrafts < ActiveRecord::Migration
    def up
        rename_column :dynasty_drafts, :started_at, :start_datetime
        remove_column :dynasty_drafts, :number_of_rounds
    end

    def down
        add_column :dynasty_drafts, :number_of_rounds, :integer
        rename_column :dynasty_drafts, :start_datetime, :started_at
    end
end
