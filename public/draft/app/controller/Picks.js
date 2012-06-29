Ext.define('DynastyDraft.controller.Picks', {
    extend: 'Ext.app.Controller',

    stores: [ 'Teams', 'Picks', 'PickOrder' ],
    views: [ 'Picks' ],

    refs: [{
        ref: 'picksSlider',
        selector: 'viewport picks'
    }, {
        ref: 'balanceView',
        selector: 'viewport #user-balance'
    }],

    init: function() {
        this.control({
            'viewport picks': {
                //render: this.onViewRender,
            }
        });

        this.addEvents('picksucceeded');

        this.getTeamsStore().addListener('load', this.onTeamsLoaded, this);
        this.getPicksStore().addListener('changeCurrentPick', this.onChangeCurrentPick, this);
        this.application.addListener(this.application.STATUS_PICKED, this.onPlayerPicked, this);
        this.application.addListener(this.application.PICK_UPDATE, this.onPickUpdate, this);
    },

    /**
     * The purpose of this method is to take the combined team/pick data
     * returned for the team store, split the pick data out of it, and
     * inject that data into the Picks and PickOrder stores.
     *
     * When that is complete, we instantiate the animation plugin for the
     * view and initialize it.
     */
    onTeamsLoaded: function(teamStore, records) {
        var pickOrder = this.getPickOrderStore(),
            picksStore = this.getPicksStore(),
            pickRecordsRaw = [],
            view = this.getPicksSlider(),
            teamCount = teamStore.getCount();
    
        teamStore.each(function(team) {
            team.picks().each(function(pick) { // for pickorder store
                var data = pick.data;
                data['team_name'] = team.get('name');
                var pick_r = pick.get('pick_order') % teamCount
                data['pick'] = (pick_r === 0) ? teamCount : pick_r;
                pickRecordsRaw[parseInt(pick.get('pick_order')) - 1] = data;
            }, this);
        }, this);
        // bind the pick order store to the view
        view.bindStore(pickOrder);
        pickOrder.loadRawData(pickRecordsRaw);
        picksStore.loadRawData(pickRecordsRaw);
    },

    /**
     * After a player has been picked, update the current pick
     */
    onPlayerPicked: function(player_id) {
        var store = this.getPicksStore(),
            currentPick = store.getCurrentPick();
        if (currentPick) {
            console.log("saving current pick:", currentPick);
            // suspend model events until the end of the update
            currentPick.set('player_id', player_id);
            currentPick.save({
                success: function(record, operation) {
                    this.fireEvent('picksucceeded');
                    
                    // get "extra" data from the operation directly
                    var response = Ext.JSON.decode(operation.response.responseText);
                    if (response && response.balance) {
                        var balance = response.balance;
                        // update the user balance data
                        var bv = this.getBalanceView();
                        bv.tpl.overwrite(bv.getEl(), balance);
                        bv.hide().show();
                    }
                },
                failure: function() {},
                callback: function() {},
                scope: this
            });
        }
    },

    onPickUpdate: function(pickData) {
        console.log('Pick update received:', pickData);
        var store = this.getPicksStore(),
            record = store.getById(pickData.id);
        if (record) {
            console.log('\tPick record found:', record, store);
            // update the pick record
            record.beginEdit();
            record.set('player_id', pickData.player_id);
            record.set('picked_at', pickData.picked_at);
            record.endEdit();
            record.commit();
        } else {
            console.log('\tPick record not found for data:', pickData);
        }
    },

    /**
     * This method filters and limits the picks from the current pick
     * to current pick + X records where X is the number of teams in the draft.
     */
    onChangeCurrentPick: function(currentPick) {
        // chang eround number in countdown display
        console.log(currentPick);
        $('#countdown-wrap .round').text('Round ' + currentPick.data.round);

        //console.log('filtering pick order');
        var store = this.getPickOrderStore(),
            pickCount = store.getCount();
        
        if (pickCount > 0 && currentPick) {
            store.clearFilter(true);

            // if it's not supplied, infer it from the first free pick in the store
            var minPickOrder = currentPick.get('pick_order'),
                maxPickOrder = minPickOrder + this.getTeamsStore().getCount() - 1;
            
            // apply limiting filter
            store.filter([{
                fn: function(record) {
                    pickOrder = record.get('pick_order');
                    return pickOrder >= minPickOrder && pickOrder <= maxPickOrder;
                }
            }]);
        }
    }
});
