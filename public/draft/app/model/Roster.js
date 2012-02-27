Ext.define('DynastyDraft.model.Roster', {
    extend: 'Ext.data.Model',

    fields: [
        { name: 'id', allowBlank: true, type: 'int', defaultValue: null },
        { name: 'full_name', allowBlank: false, type: 'string', defaultValue: null },
        { name: 'position', allowBlank: false, type: 'string', convert: function(value) { return value.toUpperCase(); } },
        { name: 'depth', allowBlank: true, type: 'int', defaultValue: 0, convert: function(value) {
            switch (value) {
                case 0: return 'Starter';
                case 1: return 'Bench';
            }
        } },
        { name: 'team_name', allowBlank: true, type: 'string', defaultValue: 'Not Drafted' },
        { name: 'points_per_dollar', allowBlank: true, type: 'int', defaultValue: 0 },
        { name: 'bye_week', allowBlank: true, type: 'int', defaultValue: 0 },
        { name: 'contract', allowBlank: false, type: 'int', defaultValue: 0 },
        { name: 'points_last_season', allowBlank: false, type: 'int', defaultValue: 0 },
    ],

    idProperty: 'id'
});
