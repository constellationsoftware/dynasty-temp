Ext.define('DynastyDraft.controller.DraftBoard', {
    extend: 'Ext.app.Controller',

    stores: [ 'DraftBoard' ],
    views: [ 'DraftBoard' ],

    refs: [{
        ref: 'draftboardView',
        selector: 'viewport draftboard',
    }],

    init: function() {
        this.control({
            'viewport roster': {},
        });

        this.application.addListener(this.application.STATUS_PICK_SUCCESS, this.onPickSuccess, this);
    },

    onPickSuccess: function() {
        this.getDraftBoardStore().load();
    }
});
