# == Schema Information
#
# Table name: dynasty_trades
#
#  id                  :integer(4)      not null, primary key
#  league_id           :integer(4)      not null
#  initial_team_id     :integer(4)      not null
#  second_team_id      :integer(4)      not null
#  player_id           :integer(4)
#  accepted            :boolean(1)
#  open                :boolean(1)
#  offered_at          :datetime
#  accepted_at         :datetime
#  denied_at           :datetime
#  offered_player_id   :integer(4)
#  requested_player_id :integer(4)
#  offered_cash        :integer(4)
#  requested_cash      :integer(4)
#  offered_picks       :string(255)
#  requested_picks     :string(255)
#  message             :text
#

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
