#= require juggernaut

class JuggernautAdapter
    constructor: (@options = {}) ->
        @jug = new Juggernaut(@options)
        @jug.subscribe '/observer', @processWithoutAjax
        $.ajaxSetup(beforeSend: (xhr) => xhr.setRequestHeader("X-Session-ID", @jug.sessionID))
    process: (msg) =>
        klass = window[msg.class]
        throw 'Unknown class' unless klass
        switch msg.type
            when 'create'
                klass.create msg.record unless klass.exists(msg.record.id)
            when 'update'
                klass.update msg.id, msg.record
            when 'destroy'
                klass.destroy msg.id
            else
                throw 'Unknown type:' + type

    processWithoutAjax: =>
        args = arguments
        Spine.Ajax.disable =>
            @process(args...)

$ -> new JuggernautAdapter
