class JuggernautObserver < ActiveRecord::Observer
    #observe :clock

    def after_create(record)
        JuggernautPublisher.new.publish(:create, record)
    end

    def after_update(record)
        JuggernautPublisher.new.publish(:update, record)
    end

    def after_destroy(record)
        JuggernautPublisher.publish(:destroy, record)
    end
end
