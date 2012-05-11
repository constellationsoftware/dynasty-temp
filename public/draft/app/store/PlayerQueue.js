Ext.define('DynastyDraft.store.PlayerQueue', {
    extend: 'DynastyDraft.store.Salaries',
    
    data: {
        playerqueue: []
    },

    proxy: {
        type: 'memory',
        reader: {
            type: 'json',
            root: 'playerqueue',
        }
    },
});
