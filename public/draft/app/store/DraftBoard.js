Ext.define('DynastyDraft.store.DraftBoard', {
    extend: 'Ext.data.Store',

    model: 'DynastyDraft.model.DraftedPlayers',
    groupField: 'drafted_team',

    proxy: {
        type: 'rest',
        format: 'json',
        url: '/draft/players',
        pageParam: undefined,
        startParam: undefined,
        limitParam: undefined,
        reader: {
            type: 'json',
            root: 'players'
        },
        extraParams: {
            drafted: true,
            with_name: true,
            with_points: true,
            with_contract: true,
            with_position: true
       }
    }
});
