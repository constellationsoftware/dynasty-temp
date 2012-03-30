class AddTypeToDynastyEvents < ActiveRecord::Migration
    def up
        ActiveRecord::Base.connection.execute('TRUNCATE dynasty_events')
        remove_index :dynasty_accounts, :name
        change_table :dynasty_events do |t|
            t.remove        :name
            t.string        :type
            t.references    :source, :polymorphic => true
            t.references    :target, :polymorphic => true
            t.timestamps
            t.datetime      :processed_at
        end
    end

    def down
        change_table :dynasty_events do |t|
            t.string :name
            t.remove :type, :source_type, :source_id, :target_type, :target_id, :created_at, :updated_at, :processed_at
            remove_index :dynasty_accounts, :name
        end
        add_index :dynasty_accounts, :name
    end
end
