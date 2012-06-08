class AddNameToDynastyLeagues < ActiveRecord::Migration
    def up
        add_column :dynasty_leagues, :name, :string, :null => false, :limit => 50
        remove_index :dynasty_leagues, :name => 'index_dynasty_leagues_on_public_and_teams_count'
        add_index :dynasty_leagues, [ :name, :teams_count, :public ], :name => 'index_leagues_on_name_team_count_public'
    end

    def down
        remove_column :dynasty_leagues, :name, :string, :null => false, :limit => 50
        remove_index :dynasty_leagues, :name => 'index_leagues_on_name_team_count_public'
        add_index :dynasty_leagues, [ :teams_count, :public ], :name => 'index_dynasty_leagues_on_public_and_teams_count'
    end
end
