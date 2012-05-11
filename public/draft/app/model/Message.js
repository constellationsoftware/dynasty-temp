Ext.define('DynastyDraft.model.Message', {
    extend: 'Ext.data.Model',

    idgen: 'sequential',
    fields: [
        'user',
        'message',
        'timestamp',
        {
            name: 'type',
            type: 'string',
            defaultValue: 'text'
        }
    ],
});
