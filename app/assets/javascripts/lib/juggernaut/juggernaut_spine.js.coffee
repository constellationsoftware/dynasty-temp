#= require ./juggernaut_base

class JuggernautSpine extends JuggernautBase
    handleEvent: (msg) =>
        Spine.Ajax.disable => @process(msg)

    process: (msg) =>
        klass = window[msg.class]
        console.log klass
        throw 'Unknown class' unless klass
        switch msg.type
            when 'create'
                klass.create msg.record unless klass.exists(msg.id)
            when 'update'
                klass.update msg.id, $.parseJSON(msg.record)
            when 'destroy'
                klass.destroy msg.id
            else
                throw 'Unknown type:' + type

$ -> new JuggernautSpine
