Ext.define('DynastyDraft.controller.AutoPickOrder', {
    extend: 'Ext.app.Controller',

    stores: [ 'AutoPickOrder' ],
    views: [ 'AutoPickOrder' ],

    refs: [{
        ref: 'autopickorderView',
        selector: 'viewport autopickorder',
    }],

    init: function() {
        this.control({
            'viewport autopickorder': {},
        });
        this.getAutoPickOrderStore().load();
        this.application.addListener(this.application.STATUS_PICK_SUCCESS, this.onPickSuccess, this);
    },

    onPickSuccess: function() {
        this.getAutoPickOrderStore().load();
    }
});
