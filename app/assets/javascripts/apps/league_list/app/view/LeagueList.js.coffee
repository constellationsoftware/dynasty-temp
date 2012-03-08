Ext.define 'DynastyLeagueList.view.LeagueList',
    extend: 'Ext.grid.Panel'
    alias: 'widget.leaguelist'

    renderTo: 'league_list'
    height: 400
    verticalScrollerType: 'paginggridscroller'
    loadMask: true
    invalidateScrollerOnRefresh: false
    store: 'Leagues'

    tbar: [
        xtype: 'textfield'
        itemId: 'search'
        name: 'searchField'
        fieldLabel: 'Search'
        labelWidth: 45
        emptyText: 'Enter a league name'
        width: 250
    ,
        xtype: 'tbfill'
    ]

    columns: [
        text:       'Private?'
        dataIndex:  'public'
        width:      60
        menuDisabled: true
        renderer: (value) ->
            if value is false then '<img src="/assets/shared/lock.png" />' else ''
    ,
        text:       'Name'
        dataIndex:  'name'
        xtype:      'gridcolumn'
        flex:       1
        menuDisabled: true
    ,
        text:       'Manager'
        dataIndex:  'manager'
        xtype:      'gridcolumn'
        sortable:   false
        menuDisabled: true
        flex:       1
    ,
        text:       'Teams'
        dataIndex:  'team_count'
        xtype:      'gridcolumn'
        menuDisabled: true
        width:      55
        align:      'right'
    ,
        text:       'Size'
        dataIndex:  'size'
        xtype:      'gridcolumn'
        menuDisabled: true
        width:      45
        align:      'right'
#    ,
#        xtype:      'actioncolumn'
#        width:      50
#        items: [
#            icon:   '/assets/shared/'
#        ]
    ]

    constructor: ->
        @callParent(arguments...)
        Ext.EventManager.onWindowResize @fireResize, @

    fireResize: (w, h) ->
        container = @getEl().parent()
        size = if container? then container.getSize() else { width: w, height: h }

        # setSize is the single entry point to layouts
        @setSize size.width, size.height
