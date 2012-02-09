class Games extends Spine.Controller
    constructor: ->
        super
        @week = window.WEEK
        Game.bind 'refresh', @render

        # bind to global clock update event
        Spine.bind 'clock:update', @onClockUpdate

    onClockUpdate: (clock) =>
        @week = clock.week

        $('ul#game_weeks li').each (i, e) ->
            $(e).removeClass('current')
            $(e).addClass('current') if (i + 1) == clock.week

        # refresh the scoring
        Game.fetch()

window.Games = Games


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
