class AddMottoToDynastyTeams < ActiveRecord::Migration
    def up
        add_column :dynasty_teams, :motto, :string
    end

    def down
        remove_column :dynasty_teams, :motto
    end
end
