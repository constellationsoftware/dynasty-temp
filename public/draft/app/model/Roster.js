Ext.define('DynastyDraft.model.Roster', {
    extend: 'Ext.data.Model',

    fields: [
        { name: 'id', allowBlank: true, type: 'int', defaultValue: null },
        { name: 'string', allowBlank: false, type: 'int', mapping: 'string', defaultValue: '' },
        { name: 'full_name', allowBlank: false, type: 'string', mapping: 'player.name.full_name' },
        { name: 'position', allowBlank: true, type: 'string', defaultValue: '' },
        { name: 'bye_week', allowBlank: true, type: 'int', mapping: 'player.contract.bye_week', defaultValue: 0 },
    ],

    idProperty: 'id'
});
