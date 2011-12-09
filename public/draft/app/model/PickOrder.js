Ext.define('DynastyDraft.model.PickOrder', {
    extend: 'Ext.data.Model',

    fields: [
        { name: 'id', allowBlank: true, type: 'int', defaultValue: null },
        { name: 'team_name', allowBlank: false, type: 'string' },
        { name: 'pick_order', allowBlank: false, type: 'int' },
        { name: 'round', allowBlank: false, type: 'int', defaultValue: 1 },
        { name: 'pick', allowBlank: false, type: 'int', defaultValue: 1 },
    ],

    idProperty: 'id'
});
