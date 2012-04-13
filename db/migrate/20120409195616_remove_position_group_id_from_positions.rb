class RemovePositionGroupIdFromPositions < ActiveRecord::Migration
    def change
        remove_column :positions, :position_group_id
    end
end
