class CreateDynastyUserAddresses < ActiveRecord::Migration
    def up
        create_table :dynasty_user_addresses, :options => 'default charset=utf8 collate utf8_general_ci' do |t|
            t.integer :user_id, :null => false
            t.string  :street, :limit => 128, :null => false
            t.string  :street2, :limit => 64
            t.string  :city, :limit => 50, :null => false
            t.string  :zip, :limit => 10, :null => false
            t.string  :state, :limit => 32, :null => false
            t.string  :country, :limit => 64, :null => false
        end
    end

    def down
        drop_table :dynasty_user_addresses
    end
end
