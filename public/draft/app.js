Ext.Loader.setConfig({
    enabled: true,
    disableCaching: true,
    //paths: { '<appName>': '.', 'Ext': '/draft/lib/extjs/src', 'Ext.ux': '/draft/lib/extjs/ux' }
});

Ext.application({
    name: 'DynastyDraft',
    appFolder: '/draft/app',
    autoCreateViewport: true,

    requires: [ 'DynastyDraft.data.Socket' ],

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
        'PlayerQueue',
        'ShoutBox',
        'Timer',
        'Roster',
    ],

    launch: function() {
        Ext.tip.QuickTipManager.init();
        Ext.apply(Ext.tip.QuickTipManager.getQuickTip(), {
            showDelay: 50      // Show 50ms after entering target
        });
    }
});
