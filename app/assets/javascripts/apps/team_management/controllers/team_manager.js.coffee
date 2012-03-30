class TeamManager extends Spine.Controller
    constructor: ->
        #new GameSummary()
        new GameScoring()
        # new Accounts() # waiting to see what happens with the mocks for this

        # Pull in players
        new StartingPlayers el: 'table#starters > tbody'
        new BenchPlayers el: 'table#bench > tbody'

window.TeamManager = TeamManager
