class RemoveSizeFromDynastyLeagues < ActiveRecord::Migration
    def change
        remove_column :dynasty_leagues, :size
    end
end
