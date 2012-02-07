class TeamManagerApp extends Spine.Controller
    BENCH_PLAYER_DEPTH: 0
    STARTING_PLAYER_DEPTH: 1

    constructor: ->
        super el: $('.datebox')

        # Bind listeners for clock change, then instantiate the clock
        Clock.bind 'refresh', (items) => @render items[0]
        Clock.bind 'change', @render
        Clock.fetch()

        # Pull in players
        @startingPlayersController = new StartingPlayers el: 'table#starters > tbody', depth: @STARTING_PLAYER_DEPTH
        @benchPlayersController = new BenchPlayers el: 'table#bench > tbody', depth: @BENCH_PLAYER_DEPTH

    render: (item) => @html @view('clock')(item)

window.TeamManagerApp = TeamManagerApp
