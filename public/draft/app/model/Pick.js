Ext.define('DynastyDraft.model.Pick', {
    extend: 'Ext.data.Model',
    requires: [ 'DynastyDraft.data.RailsCrudWriter' ],

    fields: [
        { name: 'id', allowBlank: true, type: 'int', defaultValue: null },
        { name: 'player_id', allowBlank: true, type: 'int', defaultValue: null },
        { name: 'team_id', allowBlank: false, type: 'int' },
        { name: 'pick_order', allowBlank: false, type: 'int' },
        { name: 'picked_at', allowBlank: true, type: 'date', defaultValue: null },
        { name: 'round', allowBlank: false, type: 'int', defaultValue: 0 }
    ],

    belongsTo: [
        { model: 'DynastyDraft.model.Team', name: 'team' }
    ],

    idProperty: 'id',

    proxy: {
        type: 'rest',
        url: '/picks',
        reader: {
            type: 'json',
            root: 'picks'
        },
        writer: 'rails_crud'
    }
});
