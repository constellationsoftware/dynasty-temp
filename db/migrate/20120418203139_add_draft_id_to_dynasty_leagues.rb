class AddDraftIdToDynastyLeagues < ActiveRecord::Migration
    def change
        add_column :dynasty_leagues, :draft_id, :integer
        add_index :dynasty_leagues, :draft_id, :unique => true
    end
end
