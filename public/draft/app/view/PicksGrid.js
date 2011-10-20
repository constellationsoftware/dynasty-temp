Ext.define('DynastyDraft.view.PicksGrid', {
    extend: 'Ext.grid.Panel',
    // uncomment to enable empty grouping
    // WARNING: does not work entirely
    //requires: [ 'DynastyDraft.grid.feature.Grouping' ],

    alias: 'widget.picksgrid',
    title: 'Draft Queue',
    store: 'PlayerQueue',
    columnLines: true,
    selModel: {
        mode: "MULTI",
    },
    viewConfig: {
        plugins: [
            {
                ptype: 'gridviewdragdrop',
                dragText: 'Drag to reorder your queue',
                ddGroup: 'PlayerGridDD',
           },
        ],
    },

    columns: [
        {
            text: 'Name',
            dataIndex: 'name',
            xtype: 'gridcolumn',
            hideable: false,
            groupable: true,
            flex: 1,
        },
        {
            text: 'Salary',
            xtype: 'gridcolumn',
            dataIndex: 'salary',
        },
    ],

    features: [
        {
            ftype: 'rowbody',
        },
        {
            ftype: 'grouping',
            groupHeaderTpl: '{name} ({rows.length} Player{[values.rows.length > 1 ? "s" : ""]})',
            hideGroupedHeader: false,
            enableGroupingMenu: false,
            startCollapsed: false,
            /*
            showEmptyGroups: true,
            emptyIndicatorField: 'empty',
            emptyGroupHeaderTpl: '{name} (0 Players)',
            emptyGroupBodyTpl: 'Drag some players over from the left',
            groupCollapseParams:{
                onlyShow: function(groupValue) {
                    if (groupValue == "Quarterback") { return true; }
                    return false;
                },
                onlyHide:null
            }
            */
        }
    ],
});
