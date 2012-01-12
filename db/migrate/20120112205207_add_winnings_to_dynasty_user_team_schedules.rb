class AddWinningsToDynastyUserTeamSchedules < ActiveRecord::Migration
  def change
    add_column :dynasty_user_team_schedules, :winnings, :integer
  end
end
