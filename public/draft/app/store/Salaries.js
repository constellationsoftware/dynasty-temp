Ext.define('DynastyDraft.store.Salaries', {
    extend: 'Ext.data.Store',

    model: 'DynastyDraft.model.Salary',

    // allow the grid to interact with the paging scroller by buffering
    buffered: true,
    pageSize: 50,
    remoteSort: true,

    //groupField: 'position',

    proxy: {
        type: 'rest',
        format: 'json',
        url: '../salaries',
        /*extraParams: {
            total: 50000
        },*/
        reader: {
            root: 'results',
            totalProperty: 'total'
        },
        // sends single sort as multi parameter
        simpleSortMode: false,
        extraParams: {
            'by_position': true,
            'offense': true
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
    },
    {
        property: 'rating',
        direction: 'DESC'
    }]
});
