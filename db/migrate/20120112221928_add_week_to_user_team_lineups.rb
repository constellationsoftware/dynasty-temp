class AddWeekToUserTeamLineups < ActiveRecord::Migration
  def change
    add_column :user_team_lineups, :week, :integer
    add_column :user_team_lineups, :current, :boolean
  end
end
