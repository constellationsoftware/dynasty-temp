Ext.define('DynastyDraft.model.Salary', {
    extend: 'Ext.data.Model',

    "fields": [
        {"name":"id","allowBlank":true,"type":"int","defaultValue":null},
        {"name":"full_name","allowBlank":false,"type":"string","defaultValue":null},
        {"name":"position","allowBlank":false,"type":"string","defaultValue":""},
        {"name":"contract_amount","allowBlank":false,"type":"int","defaultValue":0},
        {"name":"person_id","allowBlank":false,"type":"int","defaultValue":0}
    ],

    "idProperty": "id",
    "associations": [
        //{"type":"belongs_to","model":"Person","name":"people"}
    ]
});
