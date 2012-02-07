class JuggernautPublisher
    def publish_resource(type, record)
        payload = {
            type:   type,
            id:     record.id,
            class:  record.class.name,
            record: (record.respond_to? 'flatten') ? record.flatten : record
        }
        Juggernaut.publish('/observer', payload)
    end
end
