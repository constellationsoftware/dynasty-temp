class Events::Base < ActiveRecord::Base
    self.abstract_class = true
    self.table_name = 'dynasty_events'

    before_create :set_type

    belongs_to :source, :polymorphic => true
    belongs_to :target, :polymorphic => true
    has_many :event_subscriptions, :class_name => 'DynastyEventSubscription', :foreign_key => :event_id
    has_many :users, :through => :event_subscriptions

    def process(*args, &block)
        block.call
        self.processed_at = Time.now
        self.save!
    end
    alias :process! :process

    protected
        def set_type
            self.type = self.class.name
        end
end
