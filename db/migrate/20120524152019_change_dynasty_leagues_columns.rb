class ChangeDynastyLeaguesColumns < ActiveRecord::Migration
    def up
        remove_column :dynasty_leagues, :slug
        remove_column :dynasty_leagues, :name
        remove_column :dynasty_leagues, :password

        remove_index :dynasty_leagues, :name => 'index_leagues_on_name_size_team_count_public'
        remove_index :dynasty_leagues, :name => 'index_dynasty_leagues_on_id_and_clock_id'

        add_index :dynasty_leagues, [ :public, :teams_count ]
    end

    def down
        remove_index :dynasty_leagues, [ :public, :teams_count ]

        add_column :dynasty_leagues, :password, :string, :limit => 32
        add_column :dynasty_leagues, :name, :string, :null => false, :limit => 50
        add_column :dynasty_leagues, :slug, :string, :null => false

        add_index :dynasty_leagues, :slug
        add_index :dynasty_leagues, [ :name, :teams_count, :public ], :name => 'index_leagues_on_name_size_team_count_public'
    end
end
