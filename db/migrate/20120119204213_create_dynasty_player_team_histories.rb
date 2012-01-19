class CreateDynastyPlayerTeamHistories < ActiveRecord::Migration
  def change
    create_table :dynasty_player_team_histories do |t|
      t.integer :player_id
      t.integer :user_team_id
      t.integer :week
      t.integer :depth
      t.integer :position_id
      t.integer :league_id

      t.timestamps

    end
  end
end
