Ext.define('DynastyDraft.controller.PicksGrid', {
    extend: 'Ext.app.Controller',

    stores: [ 'PlayerQueue' ],
    models: [ 'Player' ],
    views: [ 'PicksGrid' ],
});
