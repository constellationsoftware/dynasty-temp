Ext.define('DynastyDraft.model.Update', {
    extend: 'Ext.data.Model',
    fields: ['id', 'current_pick', 'league_id'],

    proxy: {
        type: 'rest',
        url : '/draft/users'
        reader: {
        	type: 'json',
        }
    }
});

// Uses the User Model's Proxy
Ext.create('Ext.data.Store', {
    model: 'Update'
});