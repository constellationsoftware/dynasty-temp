class PlayerItem extends Spine.Controller
    tag: 'tr'
    className: 'player-item'
    elements:
        '.controls': 'controls'
    events:
        'click [data-type=start]': 'onClickStart'
        'click [data-type=bench]': 'onClickBench'
        'click [data-type=remove]': 'onClickRemove'
        'mouseover': 'onMouseOver'
        'mouseout': 'onMouseOut'

    constructor: ->
        super
        throw '@item required' unless @item
        @item.bind 'update', @render
        @item.bind 'destroy', @remove

    render: =>
        @html @view('player')(@item)

    onClickRemove: =>
        @item.destroy() if confirm('Are you sure you want to drop this player?')

    onClickStart: =>
        $.ajax Spine.Ajax.getURL(@item),
            type: 'PUT'
            data: { player_team: { depth: 1 } }
            success: =>
                @item.depth = 1
                Player.trigger('changeDepth', @)

    onClickBench: =>
        $.ajax Spine.Ajax.getURL(@item),
            type: 'PUT'
            data: { player_team: { depth: 0 } }
            success: =>
                @item.depth = 0
                Player.trigger('changeDepth', @)

    onMouseOver: => @controls.removeClass('invisible')
    onMouseOut: => @controls.addClass('invisible')


    # Called after an element is destroyed
    remove: => @release()

window.PlayerItem = PlayerItem
