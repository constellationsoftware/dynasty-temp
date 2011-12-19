Ext.define('DynastyDraft.controller.PlayerGrid', {
    extend: 'Ext.app.Controller',

    stores: [ 'Players' ],
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
        this.application.addListener(this.application.STATUS_PICKED, this.onPickUpdate, this);
        this.application.addListener(this.application.PICK_UPDATE, this.onPickUpdate, this);
    },

    onPickUpdate: function(pick_id) {
        //this.view.getView().refresh();
        var store = this.getPlayersStore(),
            record = store.getById(pick_id);
        if (record !== null) {
            record.set('is_valid', false);
        } else {
            console.log('Player with id '+pick_id+' not found in cache. No cause for alarm.');
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
