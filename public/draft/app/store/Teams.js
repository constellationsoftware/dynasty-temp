Ext.define('DynastyDraft.store.Teams', {
    extend: 'Ext.data.Store',

    model: 'DynastyDraft.model.Team',
    autoLoad: true,

    proxy: {
        type: 'rest',
        url: '/draft/teams',
        reader: {
        	type: 'json',
        	root: 'teams'
        }
    }
});
