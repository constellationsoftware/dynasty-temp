Ext.define('DynastyDraft.controller.PlayerQueue', {
    extend: 'Ext.app.Controller',

    stores: [ 'PlayerQueue' ],
    models: [ 'Player' ],
    views: [ 'PlayerQueue' ],

    view: null,

    refs: [{
        ref: 'view',
        selector: 'playerqueue'
    }, {
        ref: 'pickButton',
        selector: 'playerqueue button'
    }],

    init: function() {
        this.control({
            'playerqueue': {
                render: this.onViewRender,
            },
            'playerqueue button': {
                click: this.forcePick,
            },
        });

        this.application.addListener(this.application.TIMEOUT, this.getPick, this);
        this.application.addListener(this.application.PICK_UPDATE, this.onPickUpdate, this);

        // enable/disable pick button on app status
        this.application.addListener(this.application.STATUS_PICKING, function() {
            this.getPickButton().setDisabled(false);
        }, this);
        this.application.addListener(this.application.STATUS_WAITING, function() {
            this.getPickButton().setDisabled(true);
        }, this);
    },

    forcePick: function() {
        var grid = this.view.getView();
        if (this.getPlayerQueueStore().count() > 0) {
            var firstRow = grid.getNode(0);
            record = grid.getRecord(firstRow);

            Ext.Msg.show({
                title: 'Confirm pick?',
                msg: 'Do you want to add ' + record.get('full_name') + ' to your roster?',
                buttons: Ext.Msg.YESNO,
                icon: Ext.Msg.QUESTION,
                fn: this.getPick,
                scope: this
            });
        }
    },

    getPick: function() {
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
            console.log(record);
            this.fireEvent('picked', record);
        } else {
            // notify listeners that pick was made
            this.fireEvent('pickfailed');
        }
    },

    onPickUpdate: function(pick_id) {
        var store = this.getPlayerQueueStore(),
            record = store.getById(pick_id);
        if (record !== null) {
            Ext.Msg.show({
                title: 'AWW HELL NAW',
                msg: 'Someone just stole ' + record.get('full_name'),
                buttons: Ext.Msg.OK,
                icon: Ext.Msg.WARNING
            });

            // remove the record from the store
            store.remove(record);
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
