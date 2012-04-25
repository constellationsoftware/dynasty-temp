class CreateDynastyWaiverWires < ActiveRecord::Migration
    def up
        create_table :dynasty_waiver_wires do |t|
            t.integer       :player_team_id
            t.integer       :team_id
            t.datetime      :end_datetime
            t.integer       :player_point_id
            t.timestamps
        end

        add_index :dynasty_waiver_wires, [ :player_team_id, :team_id ], :name => 'index_dynasty_waiver_wires_on_teams'
    end

    def down
        drop_table :dynasty_waiver_wires
    end
end
