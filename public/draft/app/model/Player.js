Ext.define('DynastyDraft.model.Player', {
    extend: 'Ext.data.Model',

    fields: [
        { name: 'id', allowBlank: true,type: 'int', defaultValue: null },
        { name: 'full_name', allowBlank: false,type: 'string', defaultValue: null },
        {
            name: 'position',
            allowBlank: false,
            type: 'string',
            defaultValue: '',
            convert: function(value) {
                var slashPos = value.indexOf('/');
                // if position is compound, use only the primary
                var position = (slashPos === -1) ? value : value.substring(0, slashPos);
                return position;
            }
        },
        { name: 'bye_week', allowBlank: true, type: 'int', defaultValue: 0 },
        { name: 'contract_amount', allowBlank: false, type: 'int', defaultValue: 0 },
        { name: 'points', allowBlank: false, type: 'int', defaultValue: 0 },
        { name: 'defensive_points', allowBlank: false, type: 'int', defaultValue: 0 },
        { name: 'fumbles_points', allowBlank: false, type: 'int', defaultValue: 0 },
        { name: 'passing_points', allowBlank: false, type: 'int', defaultValue: 0 },
        { name: 'rushing_points', allowBlank: false, type: 'int', defaultValue: 0 },
        { name: 'sacks_against_points', allowBlank: false, type: 'int', defaultValue: 0 },
        { name: 'scoring_points', allowBlank: false, type: 'int', defaultValue: 0 },
        { name: 'special_teams_points', allowBlank: false, type: 'int', defaultValue: 0 },
        { name: 'games_played', allowBlank: false, type: 'int', defaultValue: 0 },
        { name: 'consistency', allowBlank: false, type: 'int', defaultValue: 0 },
        { name: 'is_valid', allowBlank: true, type: 'int', defaultValue: 1 },
    ],

    belongsTo: {
        model: 'DynastyDraft.model.Pick',
        name: 'pick',
    },
    idProperty: 'id',
    /*proxy: {
        type: 'rest',
        url: '/draft/players',
        reader: {
            type: 'json',
            root: 'players'
        }
    }*/
});
