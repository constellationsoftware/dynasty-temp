class Players extends Spine.Controller
    _playerItems: []

    constructor: ->
        super

        throw 'Error: player depth must be specified in the options!' unless @depth?
        throw 'Error: model class is not defined!' unless Player?
        Player.bind('refresh', @addAll)
        Player.bind('create',  @addOne)
        Player.bind('changeDepth', @onChangeDepth)

        Player.fetch(@getParams())

        # bind to global clock update event
        Spine.bind 'clock:update', @onClockUpdate

    onClockUpdate: (clock) =>
        while playerItem = @_playerItems.shift()
            playerItem.item.destroy()
        Player.fetch(@getParams())

    addOne: (item) =>
        player = new PlayerItem(item: item)
        @_playerItems.push(player)
        @append player.render() if item.depth == @depth

    addAll: (players = []) =>
        for player in players
            @addOne player

    onChangeDepth: (playerItem) =>
        item = playerItem.item
        if item.depth == @depth
            @addOne(item)
        else
            playerItem.release()

    getParams: ->
        # set the params
        @params = { data: $.param({ has_depth: @depth, roster: 1, order_by_name: 1 }) }

window.Players = Players


class BenchPlayers extends Players
window.BenchPlayers = BenchPlayers


class StartingPlayers extends Players
window.StartingPlayers = StartingPlayers


