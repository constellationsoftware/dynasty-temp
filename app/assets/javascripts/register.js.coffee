#= require_self
$ ->
    $('#register').ajaxSuccess (e, transport) ->
        location = transport.getResponseHeader('location')
        window.location.reload() if location?
        #window.location = location if location?
