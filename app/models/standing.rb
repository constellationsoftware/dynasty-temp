class Standing < ActiveRecord::Base
    belongs_to :affiliation
    belongs_to :sub_season
end
