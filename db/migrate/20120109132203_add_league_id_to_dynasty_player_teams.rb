class AddLeagueIdToDynastyPlayerTeams < ActiveRecord::Migration
  def change
    add_column :dynasty_player_teams, :league_id, :integer
  end
end
