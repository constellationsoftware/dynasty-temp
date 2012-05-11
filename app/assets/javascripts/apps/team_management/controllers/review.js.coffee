class Review extends Spine.Tab
    events:
        'click .item a': 'onTabChange'

    constructor: ->
        super
        @bind 'active', @onActivate

        Game.bind 'refresh', @render

        # bind to global clock update event
        Spine.bind 'clock:update', @onClockUpdate
        @routes
            'review/week/1': -> console.log arguments

    onClockUpdate: (clock) =>
        @week = clock.week

        $('ul#game_weeks li').each (i, e) ->
            $(e).removeClass('current')
            $(e).addClass('current') if i == clock.week

        # this variable COULD be used to refresh just the (new) current game scoring
        game = Game.findByAttribute 'week', clock.week

        # refresh the scoring
        Game.fetch()

    render: (games) =>
        current_game = game for game in games when game.score?
        current_week = if current_game? then current_game.week else 1
        @html @view('review')(games: games, week: current_week)

    onActivate: -> Game.fetch()
    onTabChange: (event) =>
        target = event.currentTarget
        parent = $(target).closest('.tab[data-week]')
        if parent?
            week = parent.data 'week'
            @el.find('.active').each -> $(@).removeClass 'active'
            @el.find("#week#{week}_tab a").first().addClass 'active'
            @el.find("#week#{week}_tab_content").first().addClass 'active'

window.Review = Review


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
