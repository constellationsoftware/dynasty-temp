Ext.define('DynastyDraft.model.Message', {
    extend: 'Ext.data.Model',

    idgen: 'sequential',
    fields: [
        'user',
        'message',
        {
            name: 'action',
            type: 'boolean',
            defaultValue: 'false',
        }
    ],
});
