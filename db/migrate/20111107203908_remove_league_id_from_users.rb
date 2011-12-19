class RemoveLeagueIdFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :league_id
  end

  def down
    add_column :users, :league_id, :integer
  end
end
