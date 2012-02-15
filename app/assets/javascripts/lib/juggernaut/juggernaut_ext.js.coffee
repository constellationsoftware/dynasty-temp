#= require ./juggernaut_base

class JuggernautExt extends JuggernautBase
    handleEvent: => @process(arguments...)

    process: (msg) =>
        store = window[msg.class]
        throw "Unknown store instance: #{msg.class}" unless store
        switch msg.type
            when 'create'
                model = store.model;
                throw "#{msg.class} store is not associated with a model class!" unless model
                unless msg.record.id? and store.exists(msg.record.id)
                    record = model.create msg.record
                    store.add(record);
            when 'update'
                record = store.getById(msg.id)
                if record?
                    store.suspendEvents()
                    record.set(msg.record)
                    store.resumeEvents()
            when 'destroy'
                record = store.getById(msg.id)
                store.remove(record) if record?
            else
                throw 'Unknown type:' + type

$ -> new JuggernautExt
