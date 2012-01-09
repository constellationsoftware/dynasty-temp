class AddEventDateToPlayerEventPoints < ActiveRecord::Migration
  def change
    add_column :dynasty_player_event_points, :event_date, :datetime
  end
end
