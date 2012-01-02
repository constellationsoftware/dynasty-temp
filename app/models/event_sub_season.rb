class EventSubSeason < ActiveRecord::Base
    set_table_name 'events_sub_seasons'

    belongs_to :event
    belongs_to :season, :foreign_key => 'sub_season_id'
end
