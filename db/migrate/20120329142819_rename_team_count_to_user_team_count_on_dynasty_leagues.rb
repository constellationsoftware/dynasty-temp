class RenameTeamCountToUserTeamCountOnDynastyLeagues < ActiveRecord::Migration
    def up
        rename_column :dynasty_leagues, :team_count, :user_teams_count
    end

    def down
        rename_column :dynasty_leagues, :user_teams_count, :team_count
    end
end
