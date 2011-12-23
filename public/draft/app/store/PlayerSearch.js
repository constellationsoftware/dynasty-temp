Ext.define('DynastyDraft.store.PlayerSearch', {
    extend: 'Ext.data.Store',

    model: 'DynastyDraft.model.Player',
    remoteSort: true,
    remoteFilter: true,

    proxy: {
        type: 'rest',
        format: 'json',
        url: '/draft/players/search',
        reader: {
            type: 'json',
            root: 'players'
        },
        extraParams: {
            available: true
        }
    },
});
