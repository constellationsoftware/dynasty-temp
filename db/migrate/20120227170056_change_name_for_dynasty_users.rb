class ChangeNameForDynastyUsers < ActiveRecord::Migration
    def change
      rename_column :dynasty_users, :name, :first_name
      change_column :dynasty_users, :first_name, :string, :limit => 50, :null => false
      add_column :dynasty_users, :last_name, :string, :limit => 50, :null => false
    end
end
