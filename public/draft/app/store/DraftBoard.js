Ext.define('DynastyDraft.store.DraftBoard', {
    extend: 'Ext.data.Store',

    model: 'DynastyDraft.model.Player',
    groupField: 'drafted_team',

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
        extraParams: {
            drafted: true
        }
    }
});
