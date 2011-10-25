Ext.Loader.setConfig({
    enabled: true
});

Ext.application({
    name: 'DynastyDraft',
    appFolder: 'app',
    autoCreateViewport: true,

    requires: [
        'Ext.direct.Manager',
        'Ext.direct.RemotingProvider',
    ],
    models: [
        'Message',
    ],

    stores: [
        'PlayerStoreCharts',
        'Messages',
        'Salaries',
    ],

    controllers: [
        'PlayerGrid',
        'PicksGrid',
        'ShoutBox',
        'Timer',
    ],

    launch: function() {
        Ext.tip.QuickTipManager.init();
        Ext.apply(Ext.tip.QuickTipManager.getQuickTip(), {
            showDelay: 50      // Show 50ms after entering target
        });
    }
});
