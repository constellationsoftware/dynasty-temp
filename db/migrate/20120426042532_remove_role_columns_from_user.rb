class RemoveRoleColumnsFromUser < ActiveRecord::Migration
    def up
        remove_index :dynasty_users, :role
        remove_column :dynasty_users, :role
        remove_column :dynasty_users, :roles_mask
    end

    def down
        add_column :dynasty_users, :role, :string
        add_column :dynasty_users, :roles_mask, :integer
        add_index :dynasty_users, :role
    end
end
