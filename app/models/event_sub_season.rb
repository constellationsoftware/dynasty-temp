# == Schema Information
#
# Table name: events_sub_seasons
#
#  event_id      :integer(4)      not null
#  sub_season_id :integer(4)      not null
#

class EventSubSeason < ActiveRecord::Base
    self.table_name = 'events_sub_seasons'

    belongs_to :event
    belongs_to :season, :class_name => 'SportsDb::Season', :foreign_key => 'sub_season_id'
end
