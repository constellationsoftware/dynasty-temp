class AddTeamsToDynastyLeagues < ActiveRecord::Migration
    def up
        add_column :dynasty_leagues, :team_count, :integer
        add_index :dynasty_leagues, [ :id, :name, :size, :team_count, :public ], :name => 'index_leagues_on_name_size_team_count_public'
    end

    def down
        remove_index :dynasty_leagues, :name => 'index_leagues_on_name_size_team_count_public'
        remove_column :dynasty_leagues, :team_count
    end
end
