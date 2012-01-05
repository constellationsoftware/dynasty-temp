class CreatePlayerTeams < ActiveRecord::Migration
  def change
    create_table :dynasty_player_teams do |t|
      t.integer :player_id
      t.integer :user_team_id
      t.boolean :current
      t.timestamp :added_at
      t.timestamp :removed_at
      t.string  :details
      t.timestamps
    end
  end
end
