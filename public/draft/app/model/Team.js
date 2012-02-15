Ext.define('DynastyDraft.model.Team', {
    extend: 'Ext.data.Model',

    fields: [
        { name: 'id', allowBlank: true, type: 'int', defaultValue: null },
        { name: 'is_online', type: 'boolean', defaultValue: false },
        { name: 'user_id', allowBlank: true, type: 'int' },
        { name: 'name', allowBlank: false, type: 'string' }
    ],

    hasMany: { model: 'DynastyDraft.model.Pick', name: 'picks' },

    idProperty: 'id'
});
