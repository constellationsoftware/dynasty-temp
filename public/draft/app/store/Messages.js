Ext.define('DynastyDraft.store.Messages', {
    extend: 'Ext.data.Store',
    model: 'DynastyDraft.model.Message',
    autoLoad: true,

    data: {
        messages: [],
    },

    proxy: {
        type: 'memory',
        reader: {
            type: 'json',
            root: 'messages',
        },
    },
});
