class UserTeamBalance < ActiveRecord::Base
    money :balance, :cents => :balance_cents

    belongs_to :team,
      :class_name => 'UserTeam',
      :autosave => true,
      :touch => true,
      :inverse_of => :balance
end
