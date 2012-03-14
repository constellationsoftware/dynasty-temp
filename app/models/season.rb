class Season < ActiveRecord::Base
    alias_attribute :year, :season_key
    alias_attribute :start, :start_date_time
    alias_attribute :end, :end_date_time

    belongs_to :affiliation, :foreign_key => :league_id, :inverse_of => :seasons
    belongs_to :publisher
    has_many :event_sub_seasons
    has_many :events, :through => :event_sub_seasons
    has_many :sub_seasons
    has_many :stats, :through => :sub_seasons

    scope :current, where{ season_key.in(Season.select{ max(season_key).as('season_key') }) }
end
