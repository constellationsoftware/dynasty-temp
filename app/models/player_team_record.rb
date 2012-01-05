class PlayerTeamRecord < ActiveRecord::Base
  set_table_name 'dynasty_player_teams'
  belongs_to :player
  belongs_to :user_team
end
