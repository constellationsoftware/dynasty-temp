Ext.define('DynastyDraft.controller.PlayerQueue', {
    extend: 'Ext.app.Controller',

    stores: [ 'PlayerQueue' ],
    models: [ 'Player' ],
    views: [ 'PlayerQueueGrid' ],

    view: null,

    init: function() {
        this.control({
            'playerqueuegrid': {
                render: this.onViewRender,
            },
            'playerqueuegrid button': {
                click: this.forcePick,
            },
        });

        this.application.addListener("timerfinish", this.doPick, this);
    },

    forcePick: function() {
        this.application.fireEvent("timerstop");
        this.doPick();
    },

    doPick: function() {
        var record,
            grid = this.view.getView(); // inner grid view

        // if there are players in the queue, pop the first one off
        // otherwise grab the record from the top of the live grid
        if (this.getPlayerQueueStore().count() > 0) {
            var firstRow = grid.getNode(0);
            record = grid.getRecord(firstRow);
            this.getPlayerQueueStore().remove(record);
        } else {
            // throw up a notification that a pick was made from the main grid
            /*this.notify('A pick was made automatically for you.\nYou should add some players to your queue!');

            var playerGrid = Ext.ComponentQuery.query('playergrid')[0];
            var firstRow = playerGrid.getView().getNode(0);
            record = playerGrid.getView().getRecord(firstRow);*/
        }

        if (record) {
            // notify listeners that pick was made
            this.application.fireEvent('playerpick', record);
        }
    },

    notify: function(text) {
        text = text || ''

        Ext.create('Ext.ux.window.Notification', {
            corner: 'br',
            ui: 'light',
            closable: false,
            title: 'Your queue is empty!',
            stickOnClick: true,
            resizable: false,
            shadow: true,
            autoDestroyDelay: 4000,
            slideInDelay: 400,
            slideInAnimation: 'easeOut',
            slideDownDelay: 600,
            slideDownAnimation: 'ghost',

            iconCls: 'ux-notification-icon-information',
            html: '<p>' + text.replace('\n', '<br>') + '</p>'
        }).show();
    },

    onViewRender: function(view) { this.view = view; },
});
