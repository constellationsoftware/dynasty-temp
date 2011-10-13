Ext.Loader.setConfig({
    enabled: true
});

Ext.application({
    name: 'DynastyDraft',
    appFolder: 'app',
    autoCreateViewport: true,

    models: [
        'Person',
        'Player',
        'Message',
    ],

    stores: [
        'Players',
        'PlayerQueue',
        'PlayerStoreCharts',
        'Messages',
    ],

    controllers: [
        'PlayerGrid',
        'ShoutBox',
    ],

    launch: function() {
        Ext.QuickTips.init();
    }
});
