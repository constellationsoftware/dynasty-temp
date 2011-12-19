class RenameUserTeamPersons < ActiveRecord::Migration
  def up
  	rename_table :user_team_persons, :players
  end

  def down
  	rename_table :players, :user_team_persons
  end
end
