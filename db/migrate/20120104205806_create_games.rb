class CreateGames < ActiveRecord::Migration
  def change
    create_table :dynasty_games do |t|
      t.integer :home_team_id
      t.integer :away_team_id
      t.integer :week
      t.datetime :date

      t.timestamps
    end
  end
end
