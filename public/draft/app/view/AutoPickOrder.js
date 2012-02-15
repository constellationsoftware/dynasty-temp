Ext.define('DynastyDraft.view.AutoPickOrder', {
    extend: 'Ext.grid.Panel',
    // uncomment to enable empty grouping
    // WARNING: does not work entirely
    //requires: [ 'DynastyDraft.grid.feature.Grouping' ],

    alias: 'widget.autopickorder',
    title: 'View Full Player List',
    store: 'AutoPickOrder',
    columnLines: true,
    viewConfig: {
        plugins: [
            {
                ptype: 'gridviewdragdrop',
                dragText: 'Drag to reorder your queue',
                ddGroup: 'AutoPickDD',
            },
        ],
    },
    columns: [
        {xtype: 'rownumberer'},
        {
            text: 'Sort Order',
            dataIndex: 'sort_order',
            xtype: 'gridcolumn',
            hideable: false,
            groupable: false,
            flex: 0.15,
        },
        {
            text: 'Position',
            dataIndex: 'position',
            xtype: 'gridcolumn',
            hideable: false,
            groupable: false,
            flex: 0.15,
        },
        {
            text: 'DB Player Name',
            dataIndex: 'full_name',
            xtype: 'gridcolumn',
            hideable: false,
            groupable: false,
            flex: 1,
        },
        {
            text: 'Bye Week',
            dataIndex: 'bye_week',
            xtype: 'numbercolumn',
            align: 'right',
            format: '0',
        },
        {
            text: 'Points Last Season',
            dataIndex: 'points_last_season',
            xtype: 'numbercolumn',
            align: 'right',
            format: '0',
        },
        {
            text: 'Salary',
            dataIndex: 'contract_amount',
            xtype: 'numbercolumn',
            align: 'right',
            format: '$0,000',
        },
        {
            text: 'Points Per $1MM ',
            dataIndex: 'points_per_dollar',
            xtype: 'numbercolumn',
            align: 'right',
            format: '0',
        }
    ],
    listeners: {
        drop: function(){ alert("drop") },
    },

    features: [
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
