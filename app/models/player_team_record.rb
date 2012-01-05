class PlayerTeamRecord < ActiveRecord::Base
  set_table_name 'dynasty_team_players'
  belongs_to :player
  belongs_to :user_team
end
