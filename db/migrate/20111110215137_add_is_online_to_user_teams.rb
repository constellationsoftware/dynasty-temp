class AddIsOnlineToUserTeams < ActiveRecord::Migration
  def change
    add_column :user_teams, :is_online, :boolean, { :null => false, :default => false }
  end
end
