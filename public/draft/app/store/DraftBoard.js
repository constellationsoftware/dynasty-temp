Ext.define('DynastyDraft.store.DraftBoard', {
    extend: 'Ext.data.Store',

    model: 'DynastyDraft.model.DraftedPlayers',
    groupField: 'team',
    remoteSort: false,

    proxy: {
        type: 'rest',
        format: 'json',
        url: '/player_teams/league_roster',
        pageParam: undefined,
        startParam: undefined,
        limitParam: undefined,
        groupParam: undefined,
        reader: {
            type: 'json',
            useSimpleAccessors: true
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
