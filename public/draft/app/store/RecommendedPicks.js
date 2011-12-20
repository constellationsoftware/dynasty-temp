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
            by_rating: true,
            by_position: true,
            page: 1,
            limit: 5
        }
    },
    /*
    sorters: [{
        property: 'position',
        direction: 'ASC',
        transform: function(value) {
            var positions = [
                'QB',
                'WR',
                'RB',
                'TE',
                'K'
            ];
            var index = positions.indexOf(position);
            return index !== -1 ? index : 999;
        }
    }, {
        property: 'rating',
        direction: 'DESC'
    }]
    */
});
