class CreateDynastyEventSubscriptions < ActiveRecord::Migration
    def up
        create_table :dynasty_event_subscriptions do |t|
            t.integer :user_id, :null => false
            t.string :event_id, :null => false
            t.string :notifier, :null => false
        end
        add_index :dynasty_event_subscriptions, [ :user_id, :event_id, :notifier ]
    end

    def down
        remove_index :dynasty_event_subscriptions, [ :user_id, :event_id, :notifier ]
        drop_table :dynasty_event_subscriptions
    end
end
