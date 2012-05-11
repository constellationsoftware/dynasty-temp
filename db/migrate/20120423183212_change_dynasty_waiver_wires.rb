class ChangeDynastyWaiverWires < ActiveRecord::Migration
    def up
        remove_column :dynasty_waiver_wires, :player_point_id
        rename_table :dynasty_waiver_wires, :dynasty_waivers
        add_index :dynasty_waivers, :end_datetime
    end

    def down
        remove_index :dynasty_waivers, :end_datetime
        rename_table :dynasty_waivers, :dynasty_waiver_wires
    end
end
