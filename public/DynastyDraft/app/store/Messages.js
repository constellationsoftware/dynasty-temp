Ext.define('DynastyDraft.store.Messages', {
    extend: 'Ext.data.Store',
    model: 'DynastyDraft.model.Message',
    autoLoad: true,

    data: {
        messages: [
            {
                user: 'test',
                message: 'Test Message.',
            },
        ],
    },

    proxy: {
        type: 'memory',
        reader: {
            type: 'json',
            root: 'messages',
        },
    },
});
