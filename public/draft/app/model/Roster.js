Ext.define('DynastyDraft.model.Roster', {
    extend: 'Ext.data.Model',

    fields: [
        { name: 'id', allowBlank: true, type: 'int', defaultValue: null },
        { name: 'depth', allowBlank: false, type: 'string', mapping: 'string', convert: function(value) { return (value === 1) ? 'Starter' : 'Bench'; } },
        { name: 'full_name', allowBlank: false, type: 'string', mapping: 'player.name.full_name' },
        { name: 'position', allowBlank: true, type: 'string', defaultValue: '' },
        { name: 'bye_week', allowBlank: true, type: 'int', mapping: 'player.contract.bye_week', defaultValue: 0 },
        { name: 'contract', allowBlank: false, type: 'int', mapping: 'player.contract.amount', defaultValue: 0 },
        { name: 'points', allowBlank: false, type: 'int', mapping: 'player.points.points', defaultValue: 0 },
        { name: 'points_per_dollar', allowBlank: false, type: 'float', defaultValue: 0, convert: function(value, record) {
            return record.get('points') / record.get('contract') * 1000000
        } }
    ],

    idProperty: 'id'
});
