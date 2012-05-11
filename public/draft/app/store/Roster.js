Ext.define('DynastyDraft.store.Roster', {
    extend: 'Ext.data.Store',

    model: 'DynastyDraft.model.Roster',
    //groupField: 'position',
    autoLoad: true,

    proxy: {
        type: 'rest',
        format: 'json',
        pageParam: undefined,
        startParam: undefined,
        limitParam: undefined,
        groupParam: undefined,
        url: '/lineups/roster',
        reader: 'json',
        extraParams: {
            with_points: true,
            with_contract: true,
            with_name: true,
            with_positions: true
        }
    }
});
