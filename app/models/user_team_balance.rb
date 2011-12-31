class UserTeamBalance < ActiveRecord::Base
  set_table_name 'dynasty_team_balances'

  money :balance, :cents => :balance_cents

  belongs_to :team,
    :class_name => 'UserTeam',
    :autosave => true,
    :touch => true,
    :inverse_of => :balance
end
