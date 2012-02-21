class AddIndexesToContractsAndPlayerTeams < ActiveRecord::Migration
  def change
      add_index :dynasty_player_teams, [ :league_id, :user_team_id, :player_id ], :name => 'index_player_teams_league_user_player'
      add_index :dynasty_player_contracts, [ :person_id, :amount, :bye_week ], :name => 'index_player_contracts_player_amount_bye'
      remove_index :dynasty_positions, :abbreviation
      add_index :dynasty_positions, [ :id, :abbreviation ]
      add_index :dynasty_team_favorites, [ :team_id, :player_id, :sort_order ], :name => 'index_favorites_team_player_sort'
  end
end
