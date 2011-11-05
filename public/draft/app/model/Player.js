Ext.define('DynastyDraft.model.Player', {
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
        }, {
            name: 'salary',
            type: 'int',
            defaultValue: 0,
        }, {
            name: 'valid',
            type: 'boolean',
            defaultValue: 'false',
        }
        /*{
            name: 'empty',
            type: 'boolean',
            defaultValue: false,
        }*/
    ],

    /*validations: [
        {
            type: 'inclusion',
            field: 'position',
            list: [
                "Quarterback",
                "Running Back",
                "Wide Receiver",
                "Kicker",
                "Bench",
            ],
        }
    ],*/
});