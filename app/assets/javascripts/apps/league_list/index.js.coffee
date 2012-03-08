#= require ext
#= require_self

Ext.Loader.setConfig
    enabled: true
    disableCaching: true
    paths: '<appName>': '.', 'Ext': '/assets/extjs/src', 'Ext.ux': '/assets/lib/extjs/ux', 'Ext.override': '/assets/lib/extjs/overrides'

Ext.application
    name: 'DynastyLeagueList'
    appFolder: 'assets/apps/league_list/app'
    requires: [
        'DynastyLeagueList.view.LeagueList'
        'Ext.override.data.Store'
    ]
    stores: 'Leagues'
    models: 'League'
    views: 'LeagueList'
    enableQuickTips: false

    launch: ->
        searchFieldChangeTask = new Ext.util.DelayedTask()
        @control
            'leaguelist':
                render: @onRender

            'leaguelist textfield#search':
                change: -> searchFieldChangeTask.delay 700, @onSearchFieldChange, @, arguments

#            'leaguelist button#available':
#                click: @onToggleAvailablePlayers
        , null, @

        store = this.getLeaguesStore()
        store.guaranteeRange 0, store.pageSize - 1

        view = @getView('LeagueList').create()
        view.render()

    onSearchFieldChange: (field, value) ->
        store = @getLeaguesStore()
        if value.length is 0
            store.clearFilter()
        else
            store.filters.clear()
            if value.length > 2
                store.filter 'name', value

    onRender: (view) ->
        callback = -> @invalidateScroller()
        @getLeaguesStore().on 'load', callback, view
