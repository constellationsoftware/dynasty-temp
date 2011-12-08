class AddLastSocketIdToUserTeams < ActiveRecord::Migration
  def change
    add_column :user_teams, :last_socket_id, :string
  end
end
