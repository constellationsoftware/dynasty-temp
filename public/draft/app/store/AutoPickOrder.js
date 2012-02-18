Ext.define('DynastyDraft.store.AutoPickOrder', {
    extend: 'Ext.data.Store',

    model: 'DynastyDraft.model.Player',
    remoteSort: true,
    remoteFilter: true,

    proxy: {
        type: 'rest',
        format: 'json',
        url: '/auto_picks',
        reader: {
            type: 'json',
            root: 'players'
        },
        // sends single sort as multi parameter
        extraParams: {
            page: 1,
            limit: 500
        }
    }
});
