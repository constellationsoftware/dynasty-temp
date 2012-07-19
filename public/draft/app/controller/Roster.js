Ext.define('DynastyDraft.controller.Roster', {
    extend: 'Ext.app.Controller',

    stores: [ 'Roster' ],
    views: [ 'Roster' ],

    refs: [{
        ref: 'rosterGrid',
        selector: 'viewport roster'
    }, {
        ref: 'balanceView',
        selector: 'viewport #user-balance'
    }],

    init: function() {
        this.getRosterStore().addListener('update', this.updateSalaryTotal, this);
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
            slot.set('player_id', player.id);
            this.getRosterGrid().getView().refresh(true);
        }
    },

    updateSalaryTotal: function(store, record, op) {
        if (op === Ext.data.Model.EDIT) { // if acquiring a new pick
            var total = 0;
            store.each(function(record) {
                player_id = record.get('player_id');
                if (player_id) {
                    player = Player.find(player_id);
                    if (player) { total += parseInt(player.contract.amount); }
                }
            }, this);
            var bv = this.getBalanceView();
            bv.tpl.overwrite(bv.getEl(), { balance: window.USER_BALANCE, salary_total: total });
            bv.hide().show();
        }
    }
});
