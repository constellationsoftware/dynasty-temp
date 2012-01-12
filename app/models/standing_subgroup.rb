class StandingSubgroup < ActiveRecord::Base
    belongs_to :affiliation
    belongs_to :standing
end
