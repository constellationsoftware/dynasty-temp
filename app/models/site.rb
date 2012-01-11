class Site < ActiveRecord::Base
    belongs_to :location
    belongs_to :publisher
end
