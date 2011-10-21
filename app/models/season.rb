class Season < ActiveRecord::Base
  belongs_to :affiliation
  belongs_to :publisher
end
