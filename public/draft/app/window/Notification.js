Ext.define('DynastyDraft.window.Notification', {
    singleton: true,
    alternateClassName: 'App.Notification',
    requires: 'Ext.ux.window.Notification',

    _config: {
        alwaysOnTop: true,
        corner: 'br',
        autoDestroyDelay: 3000,
        spacing: 20,
        slideInAnimation: 'easeOut',
        slideInDelay: 400,
        slideDownAnimation: 'backOut',
        slideOutDelay: 400,
        title: '',
        closable: false,
        shadow: true,
        paddingX: 10,
        paddingY: 40
    },

    notify: function(msg, icon) {
        icon = icon || null;
        if (!msg) { throw "Notification message cannot be blank!"; };
        this._createNotification({ html:msg, iconCls: icon });
    },

    _createNotification: function(cfg) {
        var config = this._config;
        Ext.Object.merge(config, cfg);
        Ext.create('Ext.ux.window.Notification', config).show();
    }
});
