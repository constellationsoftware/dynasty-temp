class AddTierToDynastyUsers < ActiveRecord::Migration
    def up
        add_column :dynasty_users, :tier, :string
    end

    def down
        remove_column :dynasty_users, :tier
    end
end
