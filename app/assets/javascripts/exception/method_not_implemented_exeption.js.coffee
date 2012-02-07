class MethodNotImplementedException extends Error
    message: 'Method is not implemented'

    constructor: ->
        return new Error(@message)

window.MethodNotImplementedException = MethodNotImplementedException
