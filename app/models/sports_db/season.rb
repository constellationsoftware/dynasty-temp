# == Schema Information
#
# Table name: dynasty_seasons
#
#  id          :integer(4)      not null, primary key
#  affiliation :string(6)       not null
#  year        :integer(4)      not null
#  weeks       :integer(4)      default(0), not null
#  current     :boolean(1)      default(FALSE), not null
#  start_date  :date            not null
#  end_date    :date
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class SportsDb::Season < ActiveRecord::Base
    belongs_to :affiliation, :foreign_key => :league_id, :inverse_of => :seasons
    belongs_to :publisher
    has_many :event_sub_seasons
    has_many :events, :through => :event_sub_seasons
    has_many :sub_seasons
    has_many :stats, :through => :sub_seasons

    scope :current, where{ season_key.in(self.class.select{ max(season_key).as('season_key') }) }
end
