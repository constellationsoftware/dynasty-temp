class ChangeAutoPicksToDynastyTeamFavorites < ActiveRecord::Migration
    def up
        rename_table :auto_picks, :dynasty_team_favorites
        rename_column :dynasty_team_favorites, :user_team_id, :team_id
    end

    def down
        rename_column :dynasty_team_favorites, :team_id, :user_team_id
        rename_table :dynasty_team_favorites, :auto_picks
    end
end
