Ext.define('User', {
    extend: 'Ext.data.Model',
    fields: ['id', 'email'],

    proxy: {
        type: 'rest',
        url : '/users'
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