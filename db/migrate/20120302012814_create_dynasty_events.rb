class CreateDynastyEvents < ActiveRecord::Migration
    def up
        create_table :dynasty_events do |t|
            t.string :name, :null => false
        end
        add_index :dynasty_events, :name, :unique => true
    end

    def down
        remove_index :dynasty_events, :name
        drop_table :dynasty_events
    end
end
