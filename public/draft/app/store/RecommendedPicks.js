Ext.define('DynastyDraft.store.RecommendedPicks', {
    extend: 'Ext.data.Store',

    model: 'DynastyDraft.model.Player',
    remoteSort: true,
    remoteFilter: true,

    proxy: {
        type: 'rest',
        format: 'json',
        url: '/draft/players',
        pageParam: undefined,
        startParam: undefined,
        limitParam: undefined,
        reader: {
            type: 'json',
            root: 'players'
        },
        // sends single sort as multi parameter[
        simpleSortMode: false,
        extraParams: {
            available: true,
            with_name: true,
            with_points: true,
            with_contract: true,
            with_favorites: true,
            filter_positions: true,
            page: 1,
            limit: 5
        }
    },
    sorters: [{
        property: 'points',
        direction: 'DESC'
    }]
});
