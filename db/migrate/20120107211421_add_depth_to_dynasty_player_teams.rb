class AddDepthToDynastyPlayerTeams < ActiveRecord::Migration
  def change
    add_column :dynasty_player_teams, :depth, :integer
  end
end
