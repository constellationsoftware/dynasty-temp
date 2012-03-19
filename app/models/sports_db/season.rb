class SportsDb::Season < ActiveRecord::Base
    belongs_to :affiliation, :foreign_key => :league_id, :inverse_of => :seasons
    belongs_to :publisher
    has_many :event_sub_seasons
    has_many :events, :through => :event_sub_seasons
    has_many :sub_seasons
    has_many :stats, :through => :sub_seasons

    scope :current, where{ season_key.in(self.class.select{ max(season_key).as('season_key') }) }
end
