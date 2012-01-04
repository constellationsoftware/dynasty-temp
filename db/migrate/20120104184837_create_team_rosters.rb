class CreateTeamRosters < ActiveRecord::Migration
  def change
    create_table :team_rosters do |t|
      t.integer :id
      t.integer :user_team_id
      t.integer :league_id
      t.integer :weekly_payroll
      t.datetime :updated_at
      t.boolean :current
      t.integer :opponent
      t.integer :weekly_score
      t.integer :opponent_score
      t.id :week
      t.id :balance
      t.string :game_outcome
      t.integer :game_earnings

      t.timestamps
    end
  end
end
