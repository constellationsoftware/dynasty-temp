Ext.define('DynastyDraft.store.Roster', {
    extend: 'DynastyDraft.store.Players',

    model: 'DynastyDraft.model.Player',
    groupField: 'position',

    proxy: {
        type: 'rest',
        format: 'json',
        url: 'roster',
        root: 'results'
        
    },
});
