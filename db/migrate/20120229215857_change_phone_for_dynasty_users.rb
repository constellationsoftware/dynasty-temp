class ChangePhoneForDynastyUsers < ActiveRecord::Migration
    def up
        change_column :dynasty_users, :phone, :string, :limit => 32
    end

    def down
        change_column :dynasty_users, :phone, :integer
    end
end
