class AddIndexesToDynastyPlayerTeamHistories < ActiveRecord::Migration
  def change
      add_index   :dynasty_player_team_histories, :player_id
      add_index   :dynasty_player_team_histories, :user_team_id
      add_index   :dynasty_player_team_histories, :week
  end
end
