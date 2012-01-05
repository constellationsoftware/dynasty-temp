class Trade < ActiveRecord::Base
  set_table_name 'dynasty_trades'
  belongs_to :initial_team, :class_name => 'UserTeam'
  belongs_to :second_team, :class_name => 'UserTeam'
  belongs_to :offered_player, :foreign_key => 'offered_player_id', :class_name => 'Player'
  belongs_to :requested_player, :foreign_key => 'requested_player_id', :class_name => 'Player'
  belongs_to :league
  belongs_to :player

  scope :open, where(:open => TRUE)
  scope :closed, where(:open => FALSE)
  scope :accepted, closed.where(:accepted => TRUE)
  scope :denied, closed.where(:accepted => FALSE)

end
