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

        this.application.addListener("playerpick", this.onPlayerPicked, this);
    },

    onPlayerPicked: function(player) {
        this.getRosterStore().add(player);
        console.log(player);
        Ext.ux.data.Socket.request('pick', {
            id: player.get('id')
        });
    },

    onViewRender: function(view) { this.view = view; },
});
