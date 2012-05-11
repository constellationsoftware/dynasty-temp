class Players extends Spine.Controller
    _playerItems: []

    constructor: (options) ->
        super(options)

        # bind to global clock update event
        Spine.bind 'clock:update', @reloadAll

        throw 'Error: Model class is not defined!' unless @model?
        @model.bind('refresh', @onRefresh)
        @model.bind('drop', @reloadAll)
        @model.bind('changeDepth', @reloadAll)
        @model.fetch()

    addOne: (item) =>
        player = new PlayerItem(item: item)
        @_playerItems.push(player)
        @append player.render()

    addAll: (players = []) =>
        for player in players
            @addOne player

    onRefresh: =>
        @addAll(arguments...)
        @el.parents('table').trigger 'update'

    reloadAll: =>
        while playerItem = @_playerItems.shift()
            playerItem.release()
        @model.fetch()

class BenchPlayers extends Players
    constructor: (options = {}) -> super($.extend model: BenchWarmer, options)

window.BenchPlayers = BenchPlayers


class StartingPlayers extends Players
    constructor: (options = {}) -> super($.extend model: Starter, options)

window.StartingPlayers = StartingPlayers


