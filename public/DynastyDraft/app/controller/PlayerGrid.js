Ext.define('DynastyDraft.controller.PlayerGrid', {
    extend: 'Ext.app.Controller',

    init: function() {
        this.control({
            'playergrid': {
                itemdblclick: this.onRowDblClick
            },
        });
    },

    onRowDblClick: function(e, item) {
        console.log(item.get('name'));
    }
});
