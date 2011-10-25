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
