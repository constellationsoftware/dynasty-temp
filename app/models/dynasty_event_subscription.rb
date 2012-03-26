class DynastyEventSubscription < ActiveRecord::Base
    include EnumSimulator

    belongs_to :user

    # TODO: change this to whatever to facilitate the new event model
    belongs_to :event, :class_name => 'DynastyEvent'
end
