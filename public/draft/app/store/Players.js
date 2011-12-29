Ext.define('DynastyDraft.store.Players', {
    extend: 'Ext.data.Store',

    model: 'DynastyDraft.model.Player',

    // allow the grid to interact with the paging scroller by buffering
    buffered: true,
    pageSize: 50,
    remoteSort: true,

    proxy: {
        type: 'rest',
        format: 'json',
        url: '/draft/players',
        reader: {
            type: 'json',
            root: 'players',
            totalProperty: 'total'
        },
        extraParams: {
            available: true,
            by_rating: true,
            by_position: true
        }
    },

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
});
