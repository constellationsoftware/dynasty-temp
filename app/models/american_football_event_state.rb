class AmericanFootballEventState < ActiveRecord::Base
    belongs_to :document
    belongs_to :event
end
