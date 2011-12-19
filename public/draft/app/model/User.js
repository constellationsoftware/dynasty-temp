Ext.define('DynastyDraft.model.User', {
    extend: 'Ext.data.Model',
    fields: ['id', 'email'],

    proxy: {
        type: 'rest',
        url : '/draft/users'
        reader: {
        	type: 'json',
        	root: 'users'
        }
    }
});

// Uses the User Model's Proxy
Ext.create('Ext.data.Store', {
    model: 'User'
});