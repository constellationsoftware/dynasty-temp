Ext.define('DynastyDraft.store.Picks', {
    extend: 'Ext.data.Store',

    model: 'DynastyDraft.model.Pick',
    sorters: { property: 'pick_order', direction: 'ASC' },

    __currentPick: null,
    constructor: function(config) {
        this.callParent(arguments, config);
        this.addEvents('changeCurrentPick');

        var setCurrentPick = Ext.Function.bind(function() {
            var nextPick,
                lastPick = this.__currentPick;
            // this condition should only be true on first load
            if (this.__currentPick === null) {
                nextPick = this.findRecord('person_id', 0);
            } else {
                var next_order = this.__currentPick.get('pick_order') + 1;
                nextPick = this.findRecord('pick_order', next_order, 0, null, null, true);
            }
            this.__currentPick = (nextPick) ? nextPick : null;
            
            //console.log('current pick', this.__currentPick);
            // if the current pick changed
            if (this.__currentPick !== lastPick) {
                this.fireEvent('changeCurrentPick', this.__currentPick, lastPick);
            }
        }, this, null, true);

        // listen for events that will allow us to manage the "current" pick
        this.on('load', setCurrentPick);
        this.afterCommit = setCurrentPick;
    },

    getCurrentPick: function() { return this.__currentPick; }
});
