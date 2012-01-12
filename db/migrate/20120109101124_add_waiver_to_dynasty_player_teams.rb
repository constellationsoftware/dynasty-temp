class AddWaiverToDynastyPlayerTeams < ActiveRecord::Migration
    def change
        add_column :dynasty_player_teams, :waiver, :boolean
        add_column :dynasty_player_teams, :waiver_team_id, :integer
    end
end
