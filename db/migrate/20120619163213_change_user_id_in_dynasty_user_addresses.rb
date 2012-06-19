class ChangeUserIdInDynastyUserAddresses < ActiveRecord::Migration
    def up
        change_column :dynasty_user_addresses, :user_id, :integer, :null => true
    end

    def down
        change_column :dynasty_user_addresses, :user_id, :integer, :null => false
    end
end
