Ext.define('DynastyDraft.store.Roster', {
    extend: 'Ext.data.Store',

    model: 'DynastyDraft.model.Player',
    groupField: 'position',
    autoLoad: true,
    buffered: false,

    proxy: {
        type: 'rest',
        format: 'json',
        url: '/draft/players',
        reader: {
            type: 'json',
            root: 'players'
        },
        extraParams: {
            roster: true
        }
    },
});
