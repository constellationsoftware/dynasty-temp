class RemoveWinningsFromDynastyUserTeamSchedules < ActiveRecord::Migration
  def up
    remove_column :dynasty_user_team_schedules, :winnings
  end

  def down
    add_column :dynasty_user_team_schedules, :winnings, :integer
  end
end
