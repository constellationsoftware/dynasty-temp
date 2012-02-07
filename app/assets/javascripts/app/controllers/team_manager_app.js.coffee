class TeamManagerApp extends Spine.Controller
    BENCH_PLAYER_DEPTH: 0
    STARTING_PLAYER_DEPTH: 1

    constructor: ->
        new Clocks()
        new GameSummary()
        new Accounts()

        # Pull in players
        new StartingPlayers el: 'table#starters > tbody', depth: @STARTING_PLAYER_DEPTH
        new BenchPlayers el: 'table#bench > tbody', depth: @BENCH_PLAYER_DEPTH

window.TeamManagerApp = TeamManagerApp
