Ext.define('DynastyDraft.controller.RecommendedPicks', {
    extend: 'Ext.app.Controller',

    stores: [ 'RecommendedPicks' ],
    views: [ 'RecommendedPicks' ],

    refs: [{
        ref: 'dataView',
        selector: 'viewport recommendedpicks',
    }, {
        ref: 'filterCtl',
        selector: '#recommendedpickwrap combo#filter'
    }, {
        ref: 'submitButton',
        selector: '#recommendedpickwrap button#submit'
    }],

    init: function() {
        this.callParent(arguments);

        this.control({
            'viewport recommendedpicks': {
                beforerender: this.onBeforeViewRender,
                datachanged: this.onDataChanged,
                selectionchange: this.onSelectionChange,
                itemdblclick: this.onSubmit,
                itemkeydown: this.onItemKeyDown
            },

            '#recommendedpickwrap button#submit': {
                click: this.onSubmit
            },

            '#recommendedpickwrap combo#filter': {
                change: this.onFilterChanged
            }
        });

        this.addEvents('playerpicked');

        this.getRecommendedPicksStore().addListener('load', this.onRecommendedPicksLoaded, this);
        // force pick on clock timeout
        this.application.addListener(this.application.TIMEOUT, function() { this.makePick(true); }, this);
        // enable/disable pick button on app status
        this.application.addListener(this.application.STATUS_PICKING, function(data) {
            console.log(data);
            this.getRecommendedPicksStore().loadRawData(data);
            this.getSubmitButton().setDisabled(false);
        }, this);
        this.application.addListener(this.application.STATUS_WAITING, function() {
            this.getSubmitButton().setDisabled(true);
        }, this);
    },

    onBeforeViewRender: function(view) {
        // bind the view's store instance to this one
        view.bindStore(this.getRecommendedPicksStore());
    },

    onRecommendedPicksLoaded: function(store, records) {
        console.log(this.getDataView().getStore().getRange(0, this.getDataView().getStore().getCount() - 1));
        this.getDataView().select(0);
    },

    onItemKeyDown: function(me, record, item, index, e) {
        var key = e.getKey();
        if (key === Ext.EventObject.ENTER || key === Ext.EventObject.SPACE) {
            this.onSubmit();
            return false;
        }
    },

    onSubmit: function() { this.makePick(); },
    makePick: function(force) {
        force = force || false; // skips the confirmation dialog
        var me = this,
            record = this.getDataView().getSelectionModel().getSelection()[0],
            callback = function(buttonId) {
                buttonId = buttonId || null;
                if (buttonId === "yes") {
                    me.fireEvent('playerpicked', record);
                }
            };
        
        if (force) { callback(); }
        else {
            var msg = 'Do you want to add ' + record.get('full_name') + ' to your roster?';
            Ext.Msg.confirm('Confirm pick?', msg, callback, this);
        }
    },

    onDataChanged: function() {
        this.getDataView().select(0);
    },

    /**
     * When the filter control's value is changed, reload the store data
     * with the desired filter applied.
     */
    onFilterChanged: function(ctl, value) {
        var store = this.getRecommendedPicksStore();
        console.log(store);
        /**
         * Clear out filters manually, since remote filters aren't recognized
         * by the store for some reason.
         */
        if (store.filters && store.filters.items.length > 0) {
            store.filters.items = [];
            store.filters.keys = [];            
        }
        if (value !== 'all') {
            store.filter('position', value);
        } else {
            store.load();
        }
    },

    /**
     * When the selected row is changed, we need to update the delta
     * values for each stat to reflect the amount of change from the
     * equivalent stat from the selected node.
     */
    onSelectionChange: function(selectionModel, selections) {
        /**
         * If somehow the user finds a way to clear the selection, simply
         * select the last thing that was selected and don't fire an event.
         * That's what they get for being a dick.
         */
        if (selections.length === 0) {
            selectionModel.select(selectionModel.getLastSelected() ? selectionModel.getLastSelected() : 0, false, true);
        }

        var view = selectionModel.view,
            selectedNode = view.getSelectedNodes()[0],
            selectedRecord = view.getRecord(selectedNode),
            nodes = view.getNodes();
        
        // loop through view nodes
        for (var i = 0, l = nodes.length; i < l; ++i) {
            var node = nodes[i],
                el = new Ext.Element(node),
                statEls = el.query('.stats dd');
            
            // for all but the selected node, compare stat values to selected
            if (node !== selectedNode) {
                var record = view.getRecord(node);
                for (j = 0, k = statEls.length; j < k; ++j) {
                    var node = statEls[j],
                        stat = node.className,
                        el = new Ext.Element(node),
                        deltaEl = new Ext.Element(el.down('.delta')),
                        deltaValue = record.get(stat) - selectedRecord.get(stat);
                    deltaEl.removeCls(['pos', 'neg']);
                    deltaEl.update('(' + (deltaValue >= 0 ? '+' : '') + deltaValue + ')');
                    if (deltaValue > 0) { deltaEl.addCls('pos'); }
                    else if (deltaValue < 0) { deltaEl.addCls('neg'); }
                }
            }
            // clear out the delta values in the newly selected node
            else {
                for (j = 0, k = statEls.length; j < k; ++j) {
                    var node = statEls[j],
                        el = new Ext.Element(node),
                        deltaEl = new Ext.Element(el.down('.delta'));
                    deltaEl.update('');
                }
            }
        }
    }
});
