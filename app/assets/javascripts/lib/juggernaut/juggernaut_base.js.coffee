#= require juggernaut

class JuggernautBase
    constructor: (@options = {}) ->
        throw 'Error: Client ID is not defined!' unless CLIENT_ID?
        @jug = new Juggernaut(@options)
        @jug.meta = { id: CLIENT_ID }
        @jug.subscribe "/observer/#{CLIENT_ID}", @handleEvent
        $.ajaxSetup(beforeSend: (xhr) => xhr.setRequestHeader("X-Session-ID", @jug.sessionID))

window.JuggernautBase = JuggernautBase
