class Trade < ActiveRecord::Base
    self.table_name = 'dynasty_trades'
    belongs_to :initial_team, :class_name => 'Team'
    belongs_to :second_team, :class_name => 'Team'
    belongs_to :offered_player, :foreign_key => 'offered_player_id', :class_name => 'PlayerTeam'
    belongs_to :requested_player, :foreign_key => 'requested_player_id', :class_name => 'PlayerTeam'
    belongs_to :league
    has_many :transactions, :as => :eventable, :class_name => 'Account'

    scope :open, where(:open => 1)
    scope :closed, where(:open => 0)
    scope :accepted, closed.where(:accepted => 1)
    scope :denied, closed.where(:accepted => 0)
end
