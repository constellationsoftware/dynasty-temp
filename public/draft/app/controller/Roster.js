Ext.define('DynastyDraft.controller.Roster', {
    extend: 'Ext.app.Controller',

    stores: [ 'Roster' ],
    models: [ 'Player' ],
    views: [ 'Roster' ],

    view: null,

    init: function() {
        this.control({
            'rostergrid': {
                render: this.onViewRender
            },
        });

        this.application.addListener(this.application.STATUS_PICKED, this.onPlayerPicked, this);
    },

    onPlayerPicked: function(player) {
        this.getRosterStore().add(player);
    },

    onViewRender: function(view) { this.view = view; },
});
