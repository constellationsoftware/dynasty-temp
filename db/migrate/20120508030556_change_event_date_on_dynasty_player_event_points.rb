class ChangeEventDateOnDynastyPlayerEventPoints < ActiveRecord::Migration
    def up
        rename_column :dynasty_player_event_points, :event_date, :event_datetime
    end

    def down
        rename_column :dynasty_player_event_points, :event_datetime, :event_date
    end
end
