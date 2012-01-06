Ext.define('DynastyDraft.store.RecommendedPicks', {
    extend: 'Ext.data.Store',

    model: 'DynastyDraft.model.Player',
    remoteSort: true,
    remoteFilter: true,

    proxy: {
        type: 'rest',
        format: 'json',
        url: '/draft/players',
        reader: {
            type: 'json',
            root: 'players'
        },
        // sends single sort as multi parameter
        simpleSortMode: false,
        extraParams: {
            available: true,
            with_contract: true,
            filter_positions: true,
            order_by: Ext.JSON.encode({points: 'DESC'}),
            page: 1,
            limit: 5
        }
    }
});
