Ext.define('DynastyDraft.store.PlayerQueue', {
    extend: 'DynastyDraft.store.Players',

    data: {
        playerqueue: [/*{position: "Quarterback", empty: true}*/]
    },

    proxy: {
        type: 'memory',
        reader: {
            type: 'json',
            root: 'playerqueue',
        }
    },
});
