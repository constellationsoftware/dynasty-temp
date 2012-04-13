class AddIndicesToLineupsAndPositions < ActiveRecord::Migration
    def change
        remove_index :dynasty_lineups, :name => 'index_dynasty_lineups_on_all'
        add_index :dynasty_lineups, [ :position_id, :flex ]
        add_index :dynasty_lineups, :string

        add_index :dynasty_positions, :flex_position_id
    end
end
