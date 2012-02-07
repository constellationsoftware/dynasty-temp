class Players extends Spine.Controller
    constructor: ->
        super

        throw 'Error: player depth must be specified in the options!' unless @depth?
        throw 'Error: model class is not defined!' unless Player?
        Player.bind('refresh', @addAll)
        Player.bind('create',  @addOne)
        Player.bind('changeDepth', @onChangeDepth)

        # set the params
        params = { data: $.param({ has_depth: @depth, roster: 1, order_by_name: 1 }) }
        Player.fetch(params)

    addOne: (item) =>
        player = new PlayerItem(item: item)
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

window.Players = Players


class BenchPlayers extends Players
window.BenchPlayers = BenchPlayers


class StartingPlayers extends Players
window.StartingPlayers = StartingPlayers

