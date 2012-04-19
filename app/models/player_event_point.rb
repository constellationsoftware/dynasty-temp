# == Schema Information
#
# Table name: dynasty_player_event_points
#
#  id                   :integer(4)      not null, primary key
#  player_id            :integer(4)      default(0), not null
#  event_id             :integer(4)      default(0), not null
#  points               :integer(4)      default(0), not null
#  defensive_points     :integer(4)      default(0), not null
#  fumbles_points       :integer(4)      default(0), not null
#  passing_points       :integer(4)      default(0), not null
#  rushing_points       :integer(4)      default(0), not null
#  sacks_against_points :integer(4)      default(0), not null
#  scoring_points       :integer(4)      default(0), not null
#  special_teams_points :integer(4)      default(0), not null
#  created_at           :datetime
#  updated_at           :datetime
#  event_date           :datetime
#

class PlayerEventPoint < ActiveRecord::Base
    self.table_name = 'dynasty_player_event_points'
    belongs_to :player
    belongs_to :person, :foreign_key => 'player_id'
    belongs_to :event

    scope :current, PlayerEventPoint.joins(:event).where('start_date_time < ?', Clock.first.time)
    scope :by_player, lambda{ |value| where{ player_id == my{ value } } }
    scope :in_range, lambda{ |range|
        joins{ event }.where{ event.start_date_time >> my{ range } }
    }

    def self.by_event(event, player)
        query = PlayerEventPoint.where('event_id = ?', event).where('player_id = ?', player)
        query.first
    end
end
