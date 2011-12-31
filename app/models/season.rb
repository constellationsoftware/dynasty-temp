class Season < ActiveRecord::Base
  belongs_to :affiliation
  belongs_to :publisher
  has_many :sub_seasons
  has_many :events, :through => :sub_seasons
end
