Ext.define('DynastyDraft.model.DraftedPlayers', {
    extend: 'Ext.data.Model',

    fields: [
        { name: 'id', allowBlank: true, type: 'int', defaultValue: null },
        { name: 'first_name', allowBlank: false, type: 'string', mapping: 'name.first_name' },
        { name: 'last_name', allowBlank: false, type: 'string', mapping: 'name.last_name' },
        { name: 'full_name', allowBlank: false, type: 'string', mapping: 'name.full_name' },
        { name: 'position', allowBlank: true, type: 'string', mapping: 'position.abbreviation', defaultValue: '', convert: function(value) { return value.toUpperCase(); } },
        { name: 'bye_week', allowBlank: true, type: 'int', mapping: 'contract.bye_week', defaultValue: 0 },
        { name: 'contract', allowBlank: false, type: 'int', mapping: 'contract.amount', defaultValue: 0 },
        { name: 'points', allowBlank: false, type: 'int', mapping: 'points.points', defaultValue: 0 },
        { name: 'points_per_dollar', allowBlank: false, type: 'float', defaultValue: 0, convert: function(value, record) {
            return record.get('points') / record.get('contract') * 1000000
        } },
        { name: 'depth', allowBlank: true, type: 'string', mapping: 'drafted_team.depth', defaultValue: '' },
        { name: 'drafted_team', allowBlank: true, type: 'string', mapping: 'drafted_team.name', defaultValue: 'Not Drafted' }
    ],

    idProperty: 'id'
});
