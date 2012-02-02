class JuggernautObserver < ActiveRecord::Observer
    observe :messages

    def after_create(record)
        publish(:create, record)
    end

    def after_update(record)
        publish(:update, record)
    end

    def after_destroy(record)
        publish(:destroy, record)
    end

    protected
    def publish(type, record)
        Juggernaut.publish('/message_observer', {
            type:   type,
            id:     record.id,
            class:  record.class.name,
            record: (record.respond_to? 'flatten') ? record.flatten : record
        })
    end
end
