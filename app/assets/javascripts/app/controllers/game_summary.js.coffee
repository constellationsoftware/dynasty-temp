class GameSummary extends Spine.Controller
    el: '#game_summary'

    constructor: ->
        super

        @week = window.WEEK
        Game.bind 'refresh', @render

        # bind to global clock update event
        Spine.bind 'clock:update', @onClockUpdate

    render: =>
        current_game = Game.findByAttribute('week', @week)
        next_game = Game.findByAttribute('week', @week + 1)
        if current_game and next_game # middle of the season
            @html @view('game')(game: current_game, next_game: next_game)
        else if current_game # end of season
            @html @view('game_last_week')(game: current_game)
        else if next_game # beginning of season
            @html @view('game_first_week')(next_game: next_game)
        else
            @html ""

    onClockUpdate: (clock) =>
        @week = clock.week

        $('ul#game_weeks li').each (i, e) ->
            $(e).removeClass('current')
            $(e).addClass('current') if (i + 1) == clock.week

        # refresh the scoring
        Game.fetch()


window.GameSummary = GameSummary
