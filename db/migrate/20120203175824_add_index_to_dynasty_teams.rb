class AddIndexToDynastyTeams < ActiveRecord::Migration
  def change
      add_index :dynasty_teams, [ :user_id, :league_id ]
  end
end
