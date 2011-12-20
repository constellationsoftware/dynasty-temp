Ext.define('DynastyDraft.controller.Roster', {
    extend: 'Ext.app.Controller',

    stores: [ 'Roster' ],
    views: [ 'Roster' ],

    refs: [{
        ref: 'rosterView',
        selector: 'viewport roster',
    }],

    init: function() {
        this.control({
            'viewport roster': {},
        });

        this.application.addListener(this.application.STATUS_PICK_SUCCESS, this.onPickSuccess, this);
    },

    onPickSuccess: function() {
        this.getRosterStore().load();
    }
});
