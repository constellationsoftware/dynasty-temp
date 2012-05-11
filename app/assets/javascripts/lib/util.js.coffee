#= require jquery/hash_table
#= require jquery/number_format
#= require_tree ../templates/shared
#= require_self

# capitalize method for String
String::capitalize = () ->
    (this.split(/\s+/).map (word) -> word[0].toUpperCase() + word[1..-1].toLowerCase()).join ' '

String::lpad = (length, padString) ->
    str = @
    str = (padString + str) while (str.length < length)
    str

String::reverse = ->
    str = @
    ret = ''
    ret += str[c] for c in [(str.length - 1)..0]
    ret

String::chunk = (size) ->
    throw 'Chunk size must be greater that zero!' unless size > 0
    str = @
    len = Math.ceil str.length / size
    (str.substr(i * size, size) for i in [0...len])

# default options for Ajax requests through JQuery
$.ajaxSetup
    dataType: 'json'
    timeout: 10000

# global Rails API error handling
$(document).ajaxError (e, transport, status, exception) ->
    response = $.parseJSON(transport.responseText)
    if response? and errorBucket = $('#global-errors')
        for own attr, messages of response.errors
            for msg in messages
                errorBucket.append("<div class=\"alert-box error\">#{msg}</div>")

$(document).ajaxSuccess (e, transport) ->
    # If a redirect header is found, redirect!
    location = transport.getResponseHeader('location')
    #window.location.reload() if location?

    response = $.parseJSON(transport.responseText)
    if response? and errorBucket = $('#global-errors')
        for own attr, messages of response.errors
            for msg in messages
                errorBucket.append("<div class=\"alert-box error\">#{msg}</div>")

# clear out all the error boxes prior to doing an Ajax call
$(document).ajaxSend () ->
    errorBucket = $('#global-errors')
    errorBucket.children().remove() if errorBucket?

class Alert
    defaults:
        message: 'An error occurred.'
        closeable: true

    constructor: (el, options = {}) ->
        throw 'You must specify an element to receive the error message!' unless el?
        onClose = null
        if options.hasOwnProperty('close')
            onClose = options.close
            delete options.close
        alert = $(el).append JST.alert $.extend @defaults, options
        alert.one 'close', onClose if onClose?
window.Alert = Alert
