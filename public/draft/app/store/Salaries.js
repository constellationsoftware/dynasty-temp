Ext.define('DynastyDraft.store.Salaries', {
    extend: 'Ext.data.Store',

    model: 'DynastyDraft.model.Salary',

    // allow the grid to interact with the paging scroller by buffering
    buffered: true,
    pageSize: 200,
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
    },

    sorters: [{
        property: 'contract_amount',
        direction: 'DESC'
    }]
});
