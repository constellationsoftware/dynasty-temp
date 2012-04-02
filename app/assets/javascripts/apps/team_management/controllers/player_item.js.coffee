class PlayerItem extends Spine.Controller
    tag: 'tr'
    className: 'player-item'
    elements:
        '.controls': 'controls'
    events:
        'click [data-type=start]': 'onClickStart'
        'click [data-type=bench]': 'onClickBench'
        'click [data-type=removeStarter]': 'onClickDropStarter'
        'click [data-type=removeBench]': 'onClickDropBench'
        'mouseover': 'onMouseOver'
        'mouseout': 'onMouseOut'

    constructor: ->
        super
        throw '@item required' unless @item
        @item.bind 'update', @render
        @item.bind 'destroy', @remove

    render: =>
        @html @view("player/#{@item.constructor.name.underscore()}")(@item)

    onClickDropStarter: => @dropPlayer 1
    onClickDropBench: => @dropPlayer 0
    dropPlayer: (depth) =>
        klass = @item.constructor
        id = if klass.name is 'Starter' then @item.player.id else @item.id

        if confirm('Are you sure you want to drop this player?')
            $.ajax "/player_teams/#{id}/drop",
                type: 'GET'
                success: =>
                    Starter.trigger('drop', @)
                    BenchWarmer.trigger('drop', @)

    onClickStart: => @changeDepth 1
    onClickBench: => @changeDepth 0

    changeDepth: (depth) =>
        klass = @item.constructor
        id = if klass.name is 'Starter' then @item.player.id else @item.id

        $.ajax "/team/roster/#{id}",
            type: 'PUT'
            data: { player_team: { depth: depth } }
            success: =>
                Starter.trigger('changeDepth', @)
                BenchWarmer.trigger('changeDepth', @)


    onMouseOver: => @controls.removeClass('invisible')
    onMouseOut: => @controls.addClass('invisible')


    # Called after an element is destroyed
    remove: => @release()

window.PlayerItem = PlayerItem
