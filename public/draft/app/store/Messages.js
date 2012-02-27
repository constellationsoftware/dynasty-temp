Ext.define('DynastyDraft.store.Messages', {
    extend: 'Ext.data.Store',
    model: 'DynastyDraft.model.Message',

    proxy: {
        type: 'memory',
        reader: {
            type: 'json',
            root: 'messages'
        }
    }
});
