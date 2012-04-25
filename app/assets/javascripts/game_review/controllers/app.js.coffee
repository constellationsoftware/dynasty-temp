# TODO: order players by lineup ID and depth
class GameReview extends Spine.Tab
    el: '#game-review'
    constructor: ->
        super

        Game.bind 'refresh', @render
        @el.find('.collapse').on 'show', (e) =>
            data = $(e.target).data()
            @onRollOut(data.game)

    render: (games) =>
        for game in games
            $("#game#{game.id}").html(@view("game")(game: game))

    getContentEl: (week) -> "week#{week}Content"

    onRollOut: (game) ->
        unless Game.exists game
            Game.fetch
                id: game
                processData: true
                data:
                    with_lineup: true

    ###
        When a tab is activated: if the game does not exist, fetch it now
    ###
    onActivate: (tab) ->
#        data = $(tab).closest('.tab').data()
#        unless Game.exists data.game
#            Game.fetch
#                id: data.game
#                processData: true
#                data:
#                    with_lineup: true

window.GameReview = GameReview


###
class GameSummary extends Games
    el: '#game_summary'

    render: =>
        current_game = Game.findByAttribute('week', @week)
        next_game = Game.findByAttribute('week', @week + 1)
        @html @view('game')(game: current_game, next_game: next_game)

window.GameSummary = GameSummary


class GameScoring extends Games
    el: '#scoring'

    render: (games) =>
        @html @view('game_scoring')(games: games)

window.GameScoring = GameScoring
###
