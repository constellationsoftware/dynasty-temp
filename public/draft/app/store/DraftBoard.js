Ext.define('DynastyDraft.store.DraftBoard', {
    extend: 'Ext.data.Store',

    model: 'DynastyDraft.model.Player',
    groupField: 'drafted_team',
    autoLoad: true,
    buffered: false,
    pageSize: 2000,

    proxy: {
        type: 'rest',
        format: 'json',
        url: '/draft/players',
        reader: {
            type: 'json',
            root: 'players'
        },
        extraParams: {
            drafted: true,
        }
    },
});
