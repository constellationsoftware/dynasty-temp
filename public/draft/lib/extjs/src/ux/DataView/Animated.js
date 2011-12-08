/*

This file is part of Ext JS 4

Copyright (c) 2011 Sencha Inc

Contact:  http://www.sencha.com/contact

GNU General Public License Usage
This file may be used under the terms of the GNU General Public License version 3.0 as published by the Free Software Foundation and appearing in the file LICENSE included in the packaging of this file.  Please review the following information to ensure the GNU General Public License version 3.0 requirements will be met: http://www.gnu.org/copyleft/gpl.html.

If you are unsure which license is appropriate for your use, please contact the sales department at http://www.sencha.com/contact.

*/
/**
 * @class Ext.ux.DataViewTransition
 * @extends Object
 * @author Ed Spencer (http://sencha.com)
 * Transition plugin for DataViews
 */
Ext.define('Ext.ux.DataView.Animated', {
    extend: 'Ext.view.View',

    blockRefresh: true,

    /**
     * @property cachedStoreData
     * @type Object
     * A cache of existing store data, keyed by id. This is used to determine
     * whether any items were added or removed from the store on data change
     */
    cachedStoreData: null,
    duration: 750,
    idProperty: 'id',

    /**
     * Creates the plugin instance, applies defaults
     * @constructor
     * @param {Object} config Optional config object
     */
    constructor: function(config) {
        config = config || {};
        this.callParent(arguments, config);
    },

    /**
     * Initializes the transition plugin. Overrides the dataview's default refresh function
     * @param {Ext.view.View} dataview The dataview
     */
    initComponent: function() {
        this.callParent(arguments);

        if (this.getStore()) {
            //catch the store data with the snapshot immediately
            this.cacheStoreData(this.getStore().data || store.snapshot);
        }

        /* strangely does nothing
        parent.on('resize', function() {
            var store = parent.store;
            if (store.getCount() > 0) {
                // reDraw.call(this, store);
            }
        }, this);
        */
    },

    updateIndexes: function() {
        this.callParent(arguments);
        this.getTargetEl().select(this.itemSelector).each(function(element, composite, index) {
            element.id = element.dom.id = Ext.util.Format.format("{0}-{1}", this.getId(), this.getStore().getAt(index).internalId);
        }, this);
    },

    onDataChanged: function() {
        var parentEl = this.getTargetEl(),
            store = this.getStore(),
            calcItem = store.getAt(0),
            added    = this.getAdded(store),
            removed  = this.getRemoved(store),
            previous = this.getRemaining(store),
            existing = Ext.apply({}, previous, added);
        
        //hide old items
        Ext.each(removed, function(item) {
            var id = this.getId() + '-' + item.internalId;
            Ext.fly(id).animate({
                remove  : false,
                duration: duration,
                opacity : 0,
                useDisplay: true,
                callback: function() {
                    Ext.fly(id).setDisplayed(false);
                }
            });
        }, this);
        
        this.cacheStoreData(store);
        if (calcItem == undefined) { return; } //store is empty
        
        var el = Ext.get(this.getId() + "-" + calcItem.internalId);
        
        //if there is nothing rendered, force a refresh and return. This happens when loading asynchronously (was not
        //covered correctly in previous versions, which only accepted local data)
        if (!el) {
            this.refresh();
            return true;
        }
        
        //calculate the number of rows and columns we have
        var itemCount   = store.getCount(),
            itemWidth   = el.getMargin('lr') + el.getWidth(),
            itemHeight  = el.getMargin('bt') + el.getHeight(),
            dvWidth     = parentEl.getWidth(),
            columns     = Math.floor(dvWidth / itemWidth),
            rows        = Math.ceil(itemCount / columns),
            currentRows = Math.ceil(this.getExistingCount() / columns);
        
        //stores the current top and left values for each element (discovered below)
        var oldPositions = {},
            newPositions = {},
            elCache      = {};
        
        //find current positions of each element and save a reference in the elCache
        Ext.iterate(previous, function(id, item) {
            var id = item.internalId,
                el = elCache[id] = Ext.get(this.getId() + '-' + id);
            
            oldPositions[id] = {
                top : el.getTop()  - parentEl.getTop()  - el.getMargin('t') - parentEl.getPadding('t'),
                left: el.getLeft() - parentEl.getLeft() - el.getMargin('l') - parentEl.getPadding('l')
            };
        }, this);
        
        //make sure the correct styles are applied to the parent element
        parentEl.applyStyles({
            display : 'block',
            position: 'relative'
        });
        
        //set absolute positioning on all DataView items. We need to set position, left and 
        //top at the same time to avoid any flickering
        Ext.iterate(previous, function(id, item) {
            var oldPos = oldPositions[id],
                el     = elCache[id];

            if (el.getStyle('position') != 'absolute') {
                elCache[id].applyStyles({
                    position: 'absolute',
                    left    : oldPos.left + "px",
                    top     : oldPos.top + "px"
                });
            }
        });
        
        //get new positions
        var index = 0;
        Ext.iterate(store.data.items, function(item) {
            var id = item.internalId,
                el = elCache[id];
            
            var column = index % columns,
                row    = Math.floor(index / columns),
                top    = row    * itemHeight,
                left   = column * itemWidth;
            
            newPositions[id] = {
                top : top,
                left: left
            };
            
            index ++;
        }, this);
        
        //do the movements
        var startTime  = new Date(),
            duration   = this.duration,
            dataviewID = this.getId();
        
        var doAnimate = function() {
            var elapsed  = new Date() - startTime,
                fraction = elapsed / duration,
                id;
            
            if (fraction >= 1) {
                for (id in newPositions) {
                    Ext.fly(dataviewID + '-' + id).applyStyles({
                        top : newPositions[id].top + "px",
                        left: newPositions[id].left + "px"
                    });
                }
                
                Ext.TaskManager.stop(task);
            } else {
                //move each item
                for (id in newPositions) {
                    if (!previous[id]) {
                        continue;
                    }
                    
                    var oldPos  = oldPositions[id],
                        newPos  = newPositions[id],
                        oldTop  = oldPos.top,
                        newTop  = newPos.top,
                        oldLeft = oldPos.left,
                        newLeft = newPos.left,
                        diffTop = fraction * Math.abs(oldTop  - newTop),
                        diffLeft= fraction * Math.abs(oldLeft - newLeft),
                        midTop  = oldTop  > newTop  ? oldTop  - diffTop  : oldTop  + diffTop,
                        midLeft = oldLeft > newLeft ? oldLeft - diffLeft : oldLeft + diffLeft;
                    
                    Ext.fly(dataviewID + '-' + id).applyStyles({
                        top : midTop + "px",
                        left: midLeft + "px"
                    }).setDisplayed(true);
                }
            }
        };
        
        var task = {
            run     : doAnimate,
            interval: 20,
            scope   : this
        };
        
        Ext.TaskManager.start(task);
        
        //show new items
        Ext.iterate(added, function(id, item) {
            Ext.fly(this.getId() + '-' + item.internalId).applyStyles({
                top    : newPositions[item.internalId].top + "px",
                left   : newPositions[item.internalId].left + "px"
            }).setDisplayed(true);
            
            Ext.fly(this.getId() + '-' + item.internalId).animate({
                remove  : false,
                duration: duration,
                opacity : 1
            });
        }, this);
        
        this.cacheStoreData(store);
    },

    /**
     * Caches the records from a store locally for comparison later
     * @param {Ext.data.Store} store The store to cache data from
     */
    cacheStoreData: function(store) {
        this.cachedStoreData = {};
        
        store.each(function(record) {
             this.cachedStoreData[record.internalId] = record;
        }, this);
    },
    
    /**
     * Returns all records that were already in the DataView
     * @return {Object} All existing records
     */
    getExisting: function() {
        return this.cachedStoreData;
    },
    
    /**
     * Returns the total number of items that are currently visible in the DataView
     * @return {Number} The number of existing items
     */
    getExistingCount: function() {
        var count = 0,
            items = this.getExisting();
        
        for (var k in items) {
            count++;
        }
        
        return count;
    },
    
    /**
     * Returns all records in the given store that were not already present
     * @param {Ext.data.Store} store The updated store instance
     * @return {Object} Object of records not already present in the dataview in format {id: record}
     */
    getAdded: function(store) {
        var added = {};
        store.each(function(record) {
            if (!this.cachedStoreData.hasOwnProperty(record.internalId)) {
                added[record.internalId] = record;
            }
        }, this);
        
        return added;
    },
    
    /**
     * Returns all records that are present in the DataView but not the new store
     * @param {Ext.data.Store} store The updated store instance
     * @return {Array} Array of records that used to be present
     */
    getRemoved: function(store) {
        var removed = [], id;
        for (id in this.cachedStoreData) {
            if (store.findBy(function(record) {return record.internalId == id;}) == -1) {
                removed.push(this.cachedStoreData[id]);
            }
        }
        
        return removed;
    },
    
    /**
     * Returns all records that are already present and are still present in the new store
     * @param {Ext.data.Store} store The updated store instance
     * @return {Object} Object of records that are still present from last time in format {id: record}
     */
    getRemaining: function(store) {
        var remaining = {};
        store.each(function(record) {
            if (this.cachedStoreData[record.internalId] != undefined) {
                remaining[record.internalId] = record;
            }
        }, this);
        
        return remaining;
    }
});
