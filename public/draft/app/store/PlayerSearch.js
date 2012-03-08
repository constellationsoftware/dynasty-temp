Ext.define('DynastyDraft.store.PlayerSearch', {
    extend: 'Ext.data.Store',

    requires: 'Ext.data.proxy.Rest',
    model: 'DynastyDraft.model.Player',
    remoteSort: true,
    remoteFilter: true,

    proxy: {
        type: 'rest',
        format: 'json',
        url: '/draft/players',
        reader: {
            type: 'json',
            root: 'players'
        },
        extraParams: {
            available: true,
            with_contract: true,
            with_points_from_season: 'current',
            order_by: Ext.JSON.encode({
                last_name: 'asc',
                first_name: 'asc'
            })
        }
    },
});
