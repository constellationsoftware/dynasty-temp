Ext.define('DynastyDraft.model.Player', {
    extend: 'Ext.data.Model',

    fields: [
        { name: 'id', allowBlank: true, type: 'int', defaultValue: null },
        { name: 'favorite', allowBlank: true, mapping: 'favorites.sort_order', type: 'int' },
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
        { name: 'dollars_per_point', allowBlank: false, type: 'float', defaultValue: 0, convert: function(value, record) {
            return record.get('contract') / record.get('points')
        } },
/*
        { name: 'defensive_points', allowBlank: false, type: 'int', defaultValue: 0 },
        { name: 'fumbles_points', allowBlank: false, type: 'int', defaultValue: 0 },
        { name: 'passing_points', allowBlank: false, type: 'int', defaultValue: 0 },
        { name: 'rushing_points', allowBlank: false, type: 'int', defaultValue: 0 },
        { name: 'sacks_against_points', allowBlank: false, type: 'int', defaultValue: 0 },
        { name: 'scoring_points', allowBlank: false, type: 'int', defaultValue: 0 },
        { name: 'special_teams_points', allowBlank: false, type: 'int', defaultValue: 0 },
        { name: 'games_played', allowBlank: false, type: 'int', defaultValue: 0 },
        { name: 'consistency', allowBlank: false, type: 'int', defaultValue: 0 },
*/
        { name: 'available', allowBlank: true, type: 'boolean', default: true }
    ],

    belongsTo: {
        model: 'DynastyDraft.model.Pick',
        name: 'pick'
    },
    idProperty: 'id'
});
