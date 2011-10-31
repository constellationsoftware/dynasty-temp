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
        
        // hardcode next user in line
        var next;
        switch (user.id) {
        case 1: // ben
            next = 2;
            break;
        case 2: // nick
            next = 1;
            break;
        case 3: // paul
            next = 2;
            break;
        default:
            next = 2;
        }

        Ext.ux.data.Socket.request('pick', {
            id: player.get('id'),
            next: next,
        });
    },

    onViewRender: function(view) { this.view = view; },
});
