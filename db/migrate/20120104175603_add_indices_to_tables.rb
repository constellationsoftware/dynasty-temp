class AddIndicesToTables < ActiveRecord::Migration
  def change
    add_index  :dynasty_users, :name
    add_index  :dynasty_users, :league_id
    add_index  :dynasty_users, :role
  end
end
