class AddUuidToUserTeam < ActiveRecord::Migration
  def change
    add_column :user_teams, :uuid, :binary, { :unique => true, :limit => 16 }
    add_index :user_teams, :uuid, { :length => 16 }
  end
end
