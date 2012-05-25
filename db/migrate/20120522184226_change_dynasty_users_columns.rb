class ChangeDynastyUsersColumns < ActiveRecord::Migration
    def up
        change_column :dynasty_users, :first_name, :string, :null => true, :limit => 50
        change_column :dynasty_users, :last_name, :string, :null => true, :limit => 50
    end

    def down
        change_column :dynasty_users, :first_name, :string, :null => false, :limit => 50
        change_column :dynasty_users, :last_name, :string, :null => false, :limit => 50
    end
end
