class ChangeLeagueIdOnDynastyTeams < ActiveRecord::Migration
    def change
        change_column :dynasty_teams, :league_id, :integer, :null => true
    end
end
