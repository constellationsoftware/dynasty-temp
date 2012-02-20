class CreateAutoPicks < ActiveRecord::Migration
  def change
    create_table :auto_picks do |t|
      t.integer :user_team_id
      t.integer :player_id
      t.integer :sort_order
      t.timestamps
    end
  end
end
