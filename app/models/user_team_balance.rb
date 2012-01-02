class UserTeamBalance < ActiveRecord::Base
  set_table_name 'dynasty_team_balances'

  money :balance, :cents => :balance_cents

  belongs_to :team,
    :class_name => 'UserTeam',
    :autosave => true,
    :touch => true,
    :inverse_of => :balance

  after_create :initial_balance
  # @return [Object]
  # TODO The initial balance should be set by league settings
  def initial_balance
    self.balance_cents = Money.new(75000000000)
    self.save
  end

end
