class AddIndexToDynastyPlayerTeams < ActiveRecord::Migration
  def change
      add_index :dynasty_player_teams, [ :position_id, :depth, :id, :current, :user_team_id ], { :name => 'index_position_counts_by_team' }
  end
end
