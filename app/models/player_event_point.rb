class PlayerEventPoint < ActiveRecord::Base
  set_table_name 'dynasty_player_event_points'
  belongs_to :player
  belongs_to :person, :foreign_key=> 'player_id'
  belongs_to :event


#def start_date_time
#  self.event.start_date_time
#end
#
#def self.past
#  where('start_date_time <= ?', Clock.first.time)
#end
#
#def self.future
#  where('start_date_time >= ?', Clock.first.time)
#end
#
#scope :past_event, self.past
#scope :future_event, self.future





end
