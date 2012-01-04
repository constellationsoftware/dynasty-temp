Ext.define('DynastyDraft.store.RecommendedPicks', {
    extend: 'Ext.data.Store',

    model: 'DynastyDraft.model.Player',
    remoteSort: true,
    remoteFilter: true,
    autoLoad: true,

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
            weighted: true,
            by_position: true,
            page: 1,
            limit: 5
        }
    }
});
