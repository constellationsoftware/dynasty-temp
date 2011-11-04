Ext.define('DynastyDraft.controller.PlayerGrid', {
    extend: 'Ext.app.Controller',

    stores: [ 'Players' ],
    models: [ 'Player' ],
    views: [ 'PlayerGrid' ],

    view: null,

    init: function() {
        this.control({
            'playergrid': {
                itemdblclick: this.onRowDblClick,
                render: this.onRender,
            },
        });

        // append a "disabled" class to the row when it's picked
        this.application.addListener(this.application.STATUS_PICKED, this.onPick, this);
        this.application.addListener(this.application.LEAGUE_PICK, this.onPick, this);
    },

    onPick: function(player) {
        this.view.getView().refresh();
        var store = this.getPlayersStore(),
            record = store.getById(player.id);
        if (record !== null) {
            console.log(record);
            record.set('valid', false);
        }
    },

    onRowDblClick: function(e, item) {
        console.log(item.get('name'));
    },

    onRender: function(view) {
        this.view = view;
        
        // trigger the data store load
        view.store.guaranteeRange(0, view.store.pageSize - 1);
    }
});
