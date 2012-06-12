class CustomerProfiles < ActiveRecord::Migration
  def up
    add_column :dynasty_users, :customer_profile_id, :integer
  end

  def down
    remove_column :dynasty_users, :customer_profile_id
  end
end
