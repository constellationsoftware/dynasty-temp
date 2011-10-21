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
        Ext.tip.QuickTipManager.init();
        Ext.apply(Ext.tip.QuickTipManager.getQuickTip(), {
            showDelay: 50      // Show 50ms after entering target
        });
    }
});
