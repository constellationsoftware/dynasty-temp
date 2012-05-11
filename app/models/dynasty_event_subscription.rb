# == Schema Information
#
# Table name: dynasty_event_subscriptions
#
#  id       :integer(4)      not null, primary key
#  user_id  :integer(4)      not null
#  event_id :string(255)     not null
#  notifier :string(255)     not null
#

class DynastyEventSubscription < ActiveRecord::Base
    include EnumSimulator

    belongs_to :user

    # TODO: change this to whatever to facilitate the new event model
    belongs_to :event, :class_name => 'DynastyEvent'
end
