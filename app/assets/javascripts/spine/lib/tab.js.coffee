###
 This file provides a controller with reasonable defaults for a controller managing a tab view
###

class Spine.Tab extends Spine.Controller
    constructor: (config) ->
        if config? and config.hasOwnProperty('stack')?
            config.el = "##{key}" for key, klass of config.stack.controllers when klass is @constructor
        super
