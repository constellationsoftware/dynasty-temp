class CreateDynastyUserTeamSchedules < ActiveRecord::Migration
  def change
    create_table :dynasty_user_team_schedules do |t|
      t.integer :league_id
      t.integer :team_id
      t.integer :opponent_id
      t.integer :week
      t.integer :outcome
      t.integer :team_score
      t.integer :opponent_score


      t.timestamps
    end
  end
end
