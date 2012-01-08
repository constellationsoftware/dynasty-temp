class RemoveLeagueIdFromDynastyUsersForRealThisTime < ActiveRecord::Migration
  def change
    remove_column :dynasty_users, :league_id
  end
end
