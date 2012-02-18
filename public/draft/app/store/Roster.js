Ext.define('DynastyDraft.store.Roster', {
    extend: 'Ext.data.Store',

    model: 'DynastyDraft.model.Roster',
    groupField: 'position',
    autoLoad: true,

    proxy: {
        type: 'rest',
        format: 'json',
        pageParam: undefined,
        startParam: undefined,
        limitParam: undefined,
        url: '/team/roster',
        reader: {
            type: 'json'
        },
        extraParams: {
            with_player_points: true,
            with_player_contract: true,
            with_player_name: true,
            with_position: true
        }
    }
});
