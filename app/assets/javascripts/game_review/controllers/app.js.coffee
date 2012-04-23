# TODO: order players by lineup ID and depth
class GameReview extends Spine.Controller
    constructor: ->
        super

        @route 'week_*1': (route) => @onWeekChange route.match[1], route.match[0]
        Spine.Route.setup history: true

        $('#content .nav').on 'show', (e) =>
            parent = $(e.target).closest 'li'
            data = parent.data()
            try
                game = Game.find data.game
            catch error
                Game.fetch
                    id: data.game
                    processData: true
                    data:
                        with_lineup: true

        Game.bind 'refresh', @render

    render: (games) =>
        current_game = game for game in games when game.score?
        current_week = if current_game? then current_game.week else 1
        @html @view('review')(games: games, week: current_week)

    render: (games) =>
        for game in games
            # find the corresponding element
#            contentEl = @getContentEl game.week
#            e = @[contentEl] or null
#            unless e?
#                @elements["#week_#{game.week}Tab"] = contentEl
#                @el = $("#week_#{game.week}Tab")
            @el = $("#week_#{game.week}Tab .content").first()
            @el.html(@view("game")(game: game))
            #@html @view('review')(games: games, week: current_week)
            #@html @view("game")

    getContentEl: (week) -> "week#{week}Content"



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
