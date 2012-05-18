#= require spine/lib/spine
#= require juggernaut

class JuggernautDispatcher extends Spine.Module
    @include Spine.Events

    constructor: ->
        super

        throw 'Error: Channel is not defined!' unless CHANNEL?
        @jug = new Juggernaut(@options)
        @jug.meta = { id: CHANNEL }
        @jug.on 'reconnect', @onReconnect
        @jug.on 'disconnect', @onDisconnect
        @jug.subscribe "#{CHANNEL}", @handleEvent
        $.ajaxSetup(beforeSend: (xhr) => xhr.setRequestHeader("X-Session-ID", @jug.sessionID))

    handleEvent: (msg) =>
        console.log msg
        switch msg.type
            when 'event' then @processEvent msg.event, msg.data
            when 'alert' then @processAlert msg.event, msg.data
            when 'action' then @processAction msg.action, msg.class, msg.record
            else throw 'Unknown type:' + type

    processEvent: (event, data) ->
        console.log event, data
        if typeof data is 'string'
            try
                data = $.parseJSON(data)
            catch error
                console.log 'Data is unparseable or not a JSON-formatted string'
        if data isnt null then @trigger(event, data) else @trigger(event)

    processAlert: (event, data) ->
        console.log event, data
        @trigger(event, data)

    ###
    # Processing an action involves figuring out if it's a new record, an update to an existing
    # record, or a record that needs removed from client-side models.
    #
    # Unlike the other processors, this one does not fire an event directly, but directs the
    # store instance to take action internally, thus delegating the responsibility of firing
    # events to it.
    ###
    processAction: (action, klass, data) ->
        store = window[klass]
        throw "Unknown store instance: #{klass}" unless store
        switch action
            when 'create'
                model = store.model
                throw "#{klass} store is not associated with a model class!" unless model
                store.add(model.create data) unless data.id? and store.exists data.id
            when 'update'
                record = store.getById data.id
                if record?
                    store.suspendEvents()
                    record.set data
                    store.resumeEvents()
            when 'destroy'
                record = store.getById data.id
                store.remove record if record?
            else
                throw 'Unknown type:' + type

    onDisconnect: -> console.log 'disconnected'

window.JUG = new JuggernautDispatcher()
