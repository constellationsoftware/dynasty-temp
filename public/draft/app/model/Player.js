Ext.define('DynastyDraft.model.Player', {
    require: 'DynastyDraft.model.Person',
    extend: 'DynastyDraft.model.Person',

    fields: [
        { name: 'position' },
        { name: 'comp' },
        { name: 'pass_yards' },
        { name: 'pass_td' },
        {
            name: 'rating',
            type: 'float',
        },
        { name: 'interceptions' },
        { name: 'sacks' },
        { name: 'rush_yards' },
        { name: 'rush_td' },
        {
            name: 'fan_points',
            type: 'float',
        },
        {
            name: 'salary',
            type: 'int',
            defaultValue: 0,
        }
    ],

    proxy: {
        type: 'ajax',
        url: 'data/players.json',
        reader: {
            type: 'json',
            root: 'results'
        }
    },
});