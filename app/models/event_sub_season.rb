class EventSubSeason < ActiveRecord::Base
    self.table_name = 'events_sub_seasons'

    belongs_to :event
    belongs_to :season, :class_name => 'SportsDb::Season', :foreign_key => 'sub_season_id'
end
