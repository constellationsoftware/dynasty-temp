Ext.define 'DynastyLeagueList.store.Leagues',
    extend: 'Ext.data.Store'

    storeId: 'LeagueStore'
    model: 'DynastyLeagueList.model.League'
    remoteSort: true
    remoteSortUseMapping: true
    remoteFilter: true
    buffered: true
    pageSize: 100

    proxy:
        type: 'rest'
        format: 'json'
        url: '/leagues'
        sortParam: 'sorters'
        filterParam: 'filters'
        reader:
            type: 'json'
            root: 'leagues'
            totalProperty: 'total'
        extraParams:
            with_manager: true

    sorters: 'name'
