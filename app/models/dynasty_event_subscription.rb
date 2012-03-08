class DynastyEventSubscription < ActiveRecord::Base
    include EnumSimulator

    belongs_to :user
    belongs_to :event, :class_name => 'DynastyEvent'
end
