class CreateUserTeamLineups < ActiveRecord::Migration
  def change
    create_table :user_team_lineups do |t|
      t.integer :user_team_id
      t.integer :qb_id
      t.integer :wr1_id
      t.integer :wr2_id
      t.integer :rb1_id
      t.integer :rb2_id
      t.integer :te_id
      t.integer :k_id

      t.timestamps
    end
  end
end
