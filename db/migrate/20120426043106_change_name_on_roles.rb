class ChangeNameOnRoles < ActiveRecord::Migration
    def up
        change_column :roles, :name, :string, :limit => 32
    end

    def down
        change_column :roles, :name, :string
    end
end
