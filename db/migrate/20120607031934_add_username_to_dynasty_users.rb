class AddUsernameToDynastyUsers < ActiveRecord::Migration
    def up
        add_column :dynasty_users, :username, :string, :limit => 32
        add_column :dynasty_users, :expired_at, :datetime
        remove_index :dynasty_users, :name => 'index_dynasty_users_on_name'
        add_index :dynasty_users, [ :email, :encrypted_password ]
        add_index :dynasty_users, :username
    end

    def down
        remove_column :dynasty_users, :expired_at
        remove_column :dynasty_users, :username
        remove_index :dynasty_users, [ :email, :encrypted_password ]
    end
end
