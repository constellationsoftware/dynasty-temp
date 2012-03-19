class CreateDynastyGames < ActiveRecord::Migration
    def change
        ActiveRecord::Base.connection.execute('TRUNCATE dynasty_user_team_schedules')

        drop_table :dynasty_games
        rename_table :dynasty_user_team_schedules, :dynasty_games

        rename_column :dynasty_games, :team_id, :home_team_id
        change_column :dynasty_games, :home_team_id, :integer, :null => false
        rename_column :dynasty_games, :opponent_id, :away_team_id
        change_column :dynasty_games, :away_team_id, :integer, :null => false
        rename_column :dynasty_games, :team_score, :home_team_score
        change_column :dynasty_games, :home_team_score, :decimal, :precision => 9, :scale => 5
        rename_column :dynasty_games, :opponent_score, :away_team_score
        change_column :dynasty_games, :away_team_score, :decimal, :precision => 9, :scale => 5
        change_column :dynasty_games, :week, :integer, :null => false
        remove_column :dynasty_games, :outcome

        add_index :dynasty_games, [ :league_id, :home_team_id, :away_team_id ], :name => 'index_dynasty_games_on_league_and_teams', :unique => true
        add_index :dynasty_games, [ :id, :week ]
    end
end
