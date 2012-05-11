#= require inflections
#= require_self
Spine.Controller.include
    view: (name) ->
        JST["#{@constructor.name.underscore()}/views/#{name}"]
