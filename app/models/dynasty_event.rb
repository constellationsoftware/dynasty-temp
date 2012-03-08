class DynastyEvent < ActiveRecord::Base
=begin
    include SuperModel::Redis::Model

    validates_presence_of :id, :name

    attributes :id, :name
    indexes :id, :name
=end
    has_many :event_subscriptions, :class_name => 'DynastyEventSubscription', :foreign_key => :event_id
    has_many :users, :through => :event_subscriptions
end
