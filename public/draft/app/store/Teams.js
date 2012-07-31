Ext.define('DynastyDraft.store.Teams', {
    extend: 'Ext.data.Store',

    model: 'DynastyDraft.model.Team',
    autoLoad: true,

    proxy: {
        pageParam: undefined,
        startParam: undefined,
        limitParam: undefined,
        type: 'rest',
        url: '/teams.json',
        reader: 'json',

        extraParams: {
            with_picks: true,
            obfuscate_id: true
        }
    }
});
