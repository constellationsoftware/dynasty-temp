Ext.define('DynastyDraft.controller.Roster', {
    extend: 'Ext.app.Controller',

    stores: [ 'Roster' ],
    views: [ 'Roster' ],

    refs: [{
        ref: 'rosterGrid',
        selector: 'viewport roster'
    }],

    init: function() {
        this.control({
            'viewport roster': {}
        });
        this.application.addListener(this.application.STATUS_PICK_SUCCESS, this.onPickSucceeded, this);
    },

    onPickSucceeded: function(pick) {
        var store = this.getRosterStore();
        var i = store.findBy(function(record) {
            var position = record.get('position'),
                string = record.get('string');
            return position == pick.lineup.position && string == pick.lineup.string
        });
        if (i !== -1) {
            var slot = store.getAt(i);
            var player = Player.find(pick.player_id);
            slot.set('full_name', player.fullName());
            this.getRosterGrid().getView().refresh(true);
        }
    }
});
