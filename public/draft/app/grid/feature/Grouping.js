Ext.data.Store.override({
    getCount: function() {
        var count = this.callOverridden(arguments);
        if (count > 0 && this.emptyIndicatorField) {
            var groups = this.getGroups();
            Ext.each(groups, function(group) {
                if (group.children.length === 1 &&
                    !group.children[0].get(this.emptyIndicatorField)) {
                        return this.callOverridden();
                    }
            }, this);*/
            var record = this.getAt(0);
            if (record.get(this.emptyIndicatorField)) { return 0; }
        }

        return count;
    }
});

/**
 * This override patches in empty groups and group pinning to the grid grouping feature
 */
Ext.define('DynastyDraft.grid.feature.Grouping', {
    override: 'Ext.grid.feature.Grouping',

    // view is ready
    attachEvents: function() {
        var me = this;
        me.callOverridden(arguments);
        
        // if we're showing empty groups, copy the indicator field to the store
        if (me.showEmptyGroups) {
            me.view.store.emptyIndicatorField = me.emptyIndicatorField;
        }
    },

    modifyGroupCollapse:function(groupIdx, groupData, allGroups, feature, collapseCls) {
        var me = this;
        var showGroup, hideGroup;
        var view = feature.view,
            grid = view.up('gridpanel'),
            groupBdDomId = groupData.viewId + "-gp-" + groupData.name;

        if (view.store.initLoad == 0 && groupIdx == 1) { Ext.apply(view.store, {initLoad:1}); }
        var init = view.store.initLoad != 1;
        if (feature.groupCollapseParams) {
            if (feature.groupCollapseParams.onlyShow) {
                showGroup = feature.groupCollapseParams.onlyShow(groupData.name);
                if (init) {
                    feature.collapsedState[groupBdDomId] = !showGroup;
                }
                view.store.on('load', function() {
                    view.setHeight(grid.body.getHeight());
                });
            } else if (feature.groupCollapseParams.onlyHide) {
                showGroup = !(feature.groupCollapseParams.onlyHide(groupData.name));
                if (init) {
                    feature.collapsedState[groupBdDomId] = showGroup;
                }
                view.store.on('load', function() {
                    view.setHeight(grid.body.getHeight());
                });
            }
            if (view.store.getGroups().length==groupIdx) {
                Ext.apply(view.store,{initLoad:0});
            }
            return init ? (showGroup ? "" : collapseCls) : "";
        }
    },

    setGroupHeaderTpl: function(groupIdx, groupData, allGroups, feature) {
        var store = feature.view.store,
            defaultHeaderTpl = (new Ext.XTemplate(feature.groupHeaderTpl)).apply(groupData);
        if (feature.showEmptyGroups) {
            if (groupData.rows.length == 1) {
                if (store.getGroups()[groupIdx - 1]
                    .children[0]
                    .get(feature.emptyIndicatorField)) {
                    return (new Ext.XTemplate(feature.emptyGroupHeaderTpl)).apply(groupData);
                }
            }
        }
        return defaultHeaderTpl;
    },

    setGroupBodyTpl: function(groupIdx, groupData, allGroups, feature){
        var me = this,
            store = feature.view.store;

        if (feature.showEmptyGroups) {
            if (groupData.rows.length == 1) {
                //console.log(store.getGroups()[groupIdx - 1].children[0].get(feature.emptyIndicatorField));
                if (store.getGroups()[groupIdx - 1]
                    .children[0]
                    .get(feature.emptyIndicatorField)) {
                    return '<div class="x-grid-cell-inner x-unselectable">'+(new Ext.XTemplate(feature.emptyGroupBodyTpl)).apply(groupData)+'</div>';
                }
            }
        }
        return me.recurse(groupData);
    },

    getFeatureTpl: function(values, parent, x, xcount) {
        var me = this;
        return[
            '<tpl if="typeof rows !== \'undefined\'">',
                '<tr class="' + Ext.baseCSSPrefix + 'grid-group-hd ' + (me.startCollapsed?me.hdCollapsedCls : '') + ' {[this.modifyGroupCollapse(xindex,values,parent.rows,this.feature,"' + me.hdCollapsedCls + '")]} {hdCollapsedCls}"><td class="' + Ext.baseCSSPrefix + 'grid-cell" colspan="' + parent.columns.length + '" {[this.indentByDepth(values)]}><div class="' + Ext.baseCSSPrefix + 'grid-cell-inner"><div class="' + Ext.baseCSSPrefix + 'grid-group-title">{collapsed}{[this.setGroupHeaderTpl(xindex,values,parent.rows,this.feature)]}</div></div></td></tr>',
                '<tr id="{viewId}-gp-{name}" class="' + Ext.baseCSSPrefix + 'grid-group-body ' + (me.startCollapsed ? me.collapsedCls : '') + ' {[this.modifyGroupCollapse(xindex,values,parent.rows,this.feature,"' + me.collapsedCls + '")]} {collapsedCls}"><td class="' + Ext.baseCSSPrefix + 'grid-cell" colspan="' + parent.columns.length + '">{[this.setGroupBodyTpl(xindex,values,parent.rows,this.feature)]}</td></tr>',
            '</tpl>'
            /*
            '<tpl if="typeof rows !== \'undefined\'">',
                // group row tpl
                '<tr class="' + Ext.baseCSSPrefix + 'grid-group-hd ' + (me.startCollapsed ? me.hdCollapsedCls : '') + ' {hdCollapsedCls}"><td class="' + Ext.baseCSSPrefix + 'grid-cell" colspan="' + parent.columns.length + '" {[this.indentByDepth(values)]}><div class="' + Ext.baseCSSPrefix + 'grid-cell-inner"><div class="' + Ext.baseCSSPrefix + 'grid-group-title">{collapsed}' + me.groupHeaderTpl + '</div></div></td></tr>',
                // this is the rowbody
                '<tr id="{viewId}-gp-{name}" class="' + Ext.baseCSSPrefix + 'grid-group-body ' + (me.startCollapsed ? me.collapsedCls : '') + ' {collapsedCls}"><td colspan="' + parent.columns.length + '">{[this.recurse(values)]}</td></tr>',
            '</tpl>'
            */
        ].join('');
    },

    getFragmentTpl: function() {
        return {
            feature: this,
            modifyGroupCollapse: this.modifyGroupCollapse,
            setGroupBodyTpl: this.setGroupBodyTpl,
            setGroupHeaderTpl: this.setGroupHeaderTpl,
            indentByDepth: this.indentByDepth,
            depthToIndent: this.depthToIndent
        };
    },
});
 