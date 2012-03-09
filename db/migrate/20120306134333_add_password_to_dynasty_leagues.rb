class AddPasswordToDynastyLeagues < ActiveRecord::Migration
    def up
        add_column :dynasty_leagues, :password, :string, :limit => 32
    end

    def down
        remove_column :dynasty_leagues, :password
    end
end
