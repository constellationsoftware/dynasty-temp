class TeamManager extends Spine.Controller
    tabManager: null

    constructor: ->
        super
        tabContainer = $('#team_management dl.tabs')
        controllers = {}
        routes = {}
        for tab in tabContainer.find('dd')
            name = $(tab).data('name')
            klass = name.classify()
            if window[klass]
                controllers[name] = window[klass]
                routes[name] = name
            else
                $(tab).addClass 'inactive'
                console.log "WARNING: Spine controller class #{klass} is undefined"

        # instantiate the controller stack with our list of controllers
        @tabManager = new Spine.Stack
            controllers: controllers
            routes: routes
            el: $('#team_management .tabs-content')

        tabList = new Spine.List
            el: tabContainer
            selectFirst: true
            items: (tabName for tabName, tabKlass of controllers)
            template: (item) ->
                @view('test')(item)
        tabList.bind 'change', @onTabChange

        #tabList.render @tabs
        #new GameSummary()
        #new GameScoring()
        # new Accounts() # waiting to see what happens with the mocks for this

        # Pull in players
        #new StartingPlayers el: 'table#starters > tbody'
        #new BenchPlayers el: 'table#bench > tbody'

    onTabChange: (name) =>
        return false unless name
        @tabManager.navigate name
window.TeamManager = TeamManager
