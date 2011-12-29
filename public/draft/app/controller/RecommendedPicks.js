Ext.define('DynastyDraft.controller.RecommendedPicks', {
    extend: 'Ext.app.Controller',

    stores: [ 'RecommendedPicks' ],
    views: [ 'RecommendedPicks', 'NewPlayerDialog' ],

    refs: [{
        ref: 'dataView',
        selector: 'viewport recommendedpicks',
    }, {
        ref: 'filterCtl',
        selector: '#recommendedpickwrap combo#filter'
    }, {
        ref: 'submitButton',
        selector: '#recommendedpickwrap button#submit'
    }, {
        ref: 'editWindow',
        selector: '#recommended-pick-edit-window'
    }],

    init: function() {
        this.callParent(arguments);

        this.control({
            'viewport recommendedpicks': {
                beforerender: this.onBeforeRender,
                selectionchange: this.onSelectionChange,
                itemclick: this.onItemClick,
                itemdblclick: this.onSubmit,
                itemkeydown: this.onItemKeyDown,
                itemmouseenter: this.onItemRollover,
                itemmouseleave: this.onItemRollout,
                itemupdate: this.onItemUpdate
            },

            '#recommendedpickwrap button#submit': { click: this.onSubmit },
            '#recommendedpickwrap combo#filter': { change: this.onFilterChanged },
            '#recommended-pick-edit-window': { submit: this.onItemEditSubmit },
            '#recommended-pick-edit-window combo': { beforequery: this.onBeforeQuery }
        });

        this.addEvents('playerpicked');

        this.getRecommendedPicksStore().addListener('load', this.onRecommendedPicksLoaded, this);
        // force pick on clock timeout
        this.application.addListener(this.application.TIMEOUT, function() { this.makePick(true); }, this);
        // enable/disable pick button on app status
        this.application.addListener(this.application.STATUS_PICKING, function(data) {
            this.getRecommendedPicksStore().loadRawData(data);
            this.getSubmitButton().setDisabled(false);
        }, this);
        this.application.addListener(this.application.STATUS_WAITING, function() {
            this.getSubmitButton().setDisabled(true);
        }, this);
    },

    onBeforeRender: function(view) {
        // bind the view's store instance to this one
        view.bindStore(this.getRecommendedPicksStore());
    },

    onRecommendedPicksLoaded: function(store, records) {
        var view = this.getDataView();
        view.select(0);

        // draw edit buttons for each item
        view.getEl().select('.recommended_pick .edit', true).each(this.createEditButton);
    },

    createEditButton: function(container) {
        var button = Ext.create('Ext.button.Button', {
            text: 'Swap Player...',
            itemId: 'edit',
            renderTo: container
        });
        button.getEl().setVisibilityMode(Ext.Element.VISIBILITY).setVisible(false);
        return button;
    },

    onBeforeQuery: function(query) {
        console.log(query);
    },

    onItemUpdate: function(record, index, node) {
        var el = new Ext.Element(node),
            buttonContainer = el.down('.edit');
        this.createEditButton(buttonContainer);
        // update the stat comparison
        this.onSelectionChange();
    },

    onItemClick: function(view, record, item, i, e) {
        var target = e.getTarget(),
            button = new Ext.Element(item).down('.edit *');

        // if the click came from our "edit" button
        if (button.contains(target)) {
            var window = this.getEditWindow();
            // if the dialog has not been created, create it now
            if (!window) {
                var klass = this.getNewPlayerDialogView();
                window = new klass({
                    id: 'recommended-pick-edit-window'
                });
            }

            window.show(record);
        }
    },

    /**
     * When a new player is submitted, we want to remove the old record
     * from the store and put the new record in its place.
     */
    onItemEditSubmit: function(record, oldRecord) {
        var store = this.getRecommendedPicksStore(),
            oldIndex = store.indexOf(oldRecord),
            view = this.getDataView(),
            el = new Ext.Element(view.getNode(oldIndex));
        oldRecord.data = record.data;
        view.refreshNode(oldIndex);
    },

    onItemKeyDown: function(view, record, item, index, e) {
        var key = e.getKey();
        if (key === Ext.EventObject.ENTER || key === Ext.EventObject.SPACE) {
            this.onSubmit();
            return false;
        }
    },

    onItemRollover: function(view, record, item, i) {
        var button = new Ext.Element(item).down('.edit *');
        button.setVisible(true);
    },

    onItemRollout: function(view, record, item, i) {
        var button = new Ext.Element(item).down('.edit *');
        button.setVisible(false);
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

    /**
     * When the filter control's value is changed, reload the store data
     * with the desired filter applied.
     */
    onFilterChanged: function(ctl, value) {
        var store = this.getRecommendedPicksStore();
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
    onSelectionChange: function() {
        /**
         * If somehow the user finds a way to clear the selection, simply
         * select the last thing that was selected and don't fire an event.
         * That's what they get for being a dick.
         */
        var view = this.getDataView(),
            selectionModel = view.getSelectionModel();

        if (selectionModel.getCount() === 0) {
            selectionModel.select(selectionModel.getLastSelected() ? selectionModel.getLastSelected() : 0, false, true);
        }

        var selectedNode = view.getSelectedNodes()[0],
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
