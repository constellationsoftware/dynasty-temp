class AddColumnsToUserAddresses < ActiveRecord::Migration
  def change
    add_column :user_addresses, :ship_street, :string

    add_column :user_addresses, :ship_city, :string

    add_column :user_addresses, :ship_state, :string

    add_column :user_addresses, :ship_zip, :string

  end
end
