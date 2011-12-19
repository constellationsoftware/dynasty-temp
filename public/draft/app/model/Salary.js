Ext.define('DynastyDraft.model.Salary', {
    extend: 'Ext.data.Model',

    fields: [
        {"name":"id","allowBlank":true,"type":"int","defaultValue":null},
        {"name":"full_name","allowBlank":false,"type":"string","defaultValue":null},
        {
            "name":"position",
            "allowBlank":false,
            "type":"string",
            "defaultValue":"",
            convert: function(value) {
                var slashPos = value.indexOf('/');
                // if position is compound, use only the primary
                var position = (slashPos === -1) ? value : value.substring(0, slashPos);
                return position;
            }
        },
        {"name":"contract_amount","allowBlank":false,"type":"int","defaultValue":0},
        {"name":"points","allowBlank":false,"type":"int","defaultValue":0},
        {"name":"rating","allowBlank":false,"type":"int","defaultValue":0},
        {"name":"consistency","allowBlank":false,"type":"int","defaultValue":0},
        {"name":"is_valid","allowBlank":true,"type":"int","defaultValue":1},
    ],

    "idProperty": "id",
    "associations": [
        //{"type":"belongs_to","model":"Person","name":"people"}
    ]
});
