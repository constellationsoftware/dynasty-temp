Ext.define 'DynastyLeagueList.model.League',
    extend: 'Ext.data.Model'
    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'name'
        type: 'string'
    ,
        name: 'manager'
        type: 'string'
        mapping: 'manager.full_name'
    ,
        name: 'size'
        type: 'integer'
        defaultValue: 0
    ,
        name: 'team_count'
        type: 'integer'
        defaultValue: 0
    ,
        name: 'public'
        type: 'boolean'
        defaultValue: false
    ]
