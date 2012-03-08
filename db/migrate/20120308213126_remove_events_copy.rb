class RemoveEventsCopy < ActiveRecord::Migration
    def change
        remove_index :events_copy, :name => "IDX_events_1"
        remove_index :events_copy, :name => "IDX_FK_eve_pub_id__pub_id"
        remove_index :events_copy, :name => "IDX_FK_eve_sit_id__sit_id"
        drop_table :events_copy
    end
end
