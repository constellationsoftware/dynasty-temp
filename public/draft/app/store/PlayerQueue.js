Ext.define('DynastyDraft.store.PlayerQueue', {
    extend: 'Ext.data.Store',
    requires: 'DynastyDraft.model.Player',
    model: 'DynastyDraft.model.Player',

    proxy: {
        type: 'memory',
        reader: {
            type: 'json',
            root: 'playerqueue',
        }
    }
});
