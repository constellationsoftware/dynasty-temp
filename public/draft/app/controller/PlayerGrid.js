Ext.define('DynastyDraft.controller.PlayerGrid', {
    extend: 'Ext.app.Controller',

    stores: [ 'Players' ],
    views: [ 'PlayerGrid' ],

    refs: [{
        ref: 'playerGrid',
        selector: 'viewport playergrid'
    }],

    init: function() {
        var searchFieldChangeTask = new Ext.util.DelayedTask();
        this.control({
            'viewport playergrid': {
                itemdblclick: this.onRowDblClick,
                render: this.onRender
            },
            'viewport playergrid textfield#search': {
                change: function() {
                    searchFieldChangeTask.delay(700, this.onSearchFieldChange, this, arguments)
                }
            },
            'viewport playergrid button#available': {
                click: this.onToggleAvailablePlayers
            }
        });

        // append a "disabled" class to the row when it's picked
        this.application.addListener(this.application.STATUS_PICKED, this.onPickUpdate, this);
        this.application.addListener(this.application.PICK_UPDATE, this.onPickUpdate, this);

        //var store = this.getPlayersStore();
        //store.guaranteeRange(0, store.pageSize - 1);
    },

    onSearchFieldChange: function(field, value) {
        var store = this.getPlayersStore();
        if (value.length === 0) {
            store.clearFilter();
        } else {
            store.filters.clear();
            if (value.length > 2) {
                store.filter('name.name', value);
            }
        }
    },

    onToggleAvailablePlayers: function(button, e) {
        if (button.pressed) { button.setText('Show Unavailable'); }
        else { button.setText('Hide Unavailable'); }
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
        this.getPlayersStore().on('load', function() { this.invalidateScroller(); }, view);
    }
});
