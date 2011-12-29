class NamespaceDynastyTables < ActiveRecord::Migration
  def change
    rename_table :drafts, :dynasty_drafts
    drop_table   :dynasty_dollars
    rename_table :leagues, :dynasty_leagues
    rename_table :person_scores, :dynasty_player_points
    rename_table :picks, :dynasty_draft_picks
    rename_table :players, :dynasty_team_players
    rename_table :position_groups, :dynasty_positions
    drop_table   :salaries
    rename_table :trades, :dynasty_trades
    rename_table :user_teams, :dynasty_teams
    rename_table :user_team_balances, :dynasty_team_balances
    rename_table :users, :dynasty_users
  end
end
