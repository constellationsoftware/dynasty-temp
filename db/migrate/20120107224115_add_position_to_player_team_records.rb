class AddPositionToPlayerTeamRecords < ActiveRecord::Migration
  def change
    add_column :dynasty_player_teams, :position_id, :integer
  end
end
