class TeamManagerApp extends Spine.Controller
    constructor: ->
        new Clocks()
        new GameSummary()
        new GameScoring()
        new Accounts()

        # Pull in players
        new StartingPlayers el: 'table#starters > tbody'
        new BenchPlayers el: 'table#bench > tbody'

window.TeamManagerApp = TeamManagerApp
