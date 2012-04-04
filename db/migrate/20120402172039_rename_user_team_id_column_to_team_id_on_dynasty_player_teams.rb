class RenameUserTeamIdColumnToTeamIdOnDynastyPlayerTeams < ActiveRecord::Migration
    def up
        rename_column :dynasty_player_teams, :user_team_id, :team_id
        rename_column :dynasty_leagues, :user_teams_count, :teams_count
    end

    def down
        rename_column :dynasty_leagues, :teams_count, :user_teams_count
        rename_column :dynasty_player_teams, :team_id, :user_team_id
    end
end
