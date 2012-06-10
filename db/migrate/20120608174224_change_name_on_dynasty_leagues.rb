class ChangeNameOnDynastyLeagues < ActiveRecord::Migration
    def up
        change_column :dynasty_leagues, :name, :string, :null => true, :limit => 50
    end

    def down
        change_column :dynasty_leagues, :name, :string, :null => false, :limit => 50
    end
end
