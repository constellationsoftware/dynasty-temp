class GameReview extends Spine.Tab
    el: '#game-review'
    constructor: ->
        super
        me = @
        Game.bind 'refresh', @onRefresh
        @el.find('.expander-toggle').on 'click', (e) ->
            row = $(@).closest '.game'
            data = row.data()
            me.onClick row, data.game
        @el.find('.collapse').on 'shown', ->
            expander = $(@).closest('.game').children('.expander-toggle').children('i')
            expander.removeClass('icon-chevron-down')
            expander.addClass('icon-chevron-up')
        @el.find('.collapse').on 'hidden', ->
            expander = $(@).closest('.game').children('.expander-toggle').children('i')
            expander.removeClass('icon-chevron-up')
            expander.addClass('icon-chevron-down')

    onClick: (e, game_id) ->
        if Game.exists game_id
            gameEl = $("#game#{game_id}")
            gameEl.collapse 'toggle'
        else
            # hold on to contents until loading is complete
            #row = e.children().first()
            #contents = row.detach()
            #loadEl = JST['shared/progress']()
            #e.append("Loading...")
            Game.fetch
                id: game_id
                processData: true
                data:
                    with_lineup: true
                complete: ->
                    #e.html contents

    onRefresh: (games) => @render games[0]

    render: (game) =>
        gameEl = $("#game#{game.id}")
        container = gameEl.closest('.accordion-inner')
        contentEl = gameEl.find('.content').first()
        content = @view("game")(game: game)
        gameEl.find('.content').first().html content
        gameEl.collapse 'show'
        container.fadeIn(1)

    getContentEl: (week) -> "week#{week}Content"

window.GameReview = GameReview
