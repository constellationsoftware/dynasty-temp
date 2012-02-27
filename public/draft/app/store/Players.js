Ext.define('DynastyDraft.store.Players', {
    extend: 'Ext.data.Store',

    model: 'DynastyDraft.model.Player',

    // allow the grid to interact with the paging scroller by buffering
    remoteSort: true,
    remoteSortUseMapping: true,
    remoteFilter: true,
    buffered: true,
    pageSize: 100,

    proxy: {
        type: 'rest',
        format: 'json',
        url: '/draft/players',
        sortParam: 'sorters',
        filterParam: 'filters',
        reader: {
            type: 'json',
            root: 'players',
            totalProperty: 'total'
        },
        extraParams: {
            with_name: true,
            with_points: true,
            with_contract: true,
            with_position: true,
            with_favorites: true,
            //with_available: true
        }
    },

    sorters: [{
        property: 'points',
        direction: 'DESC'
    }]
});
