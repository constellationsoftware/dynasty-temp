Ext.define('DynastyDraft.view.DraftBoard', {
    extend: 'Ext.grid.Panel',
    // uncomment to enable empty grouping
    // WARNING: does not work entirely
    //requires: [ 'DynastyDraft.grid.feature.Grouping' ],

    alias: 'widget.draftboard',
    title: 'DraftBoard',
    store: 'DraftBoard',
    columnLines: false,

    columns: [
        {
            text: 'Position',
            dataIndex: 'position',
            xtype: 'gridcolumn',
            hideable: false,
            groupable: false,
            flex: 0.15
        },
/*
        {
            text: 'Depth',
            dataIndex: 'depth',
            xtype: 'gridcolumn',
            hideable: false,
            groupable: false,
            flex: 0.15
        },
*/
        {
            text: 'DB Player Name',
            dataIndex: 'full_name',
            xtype: 'gridcolumn',
            hideable: false,
            groupable: false,
            flex: 1
        },

        {
            text: 'Team',
            dataIndex: 'team',
            xtype: 'gridcolumn',
            align: 'right'
        },
        {
            text: 'Bye Week',
            dataIndex: 'bye_week',
            xtype: 'numbercolumn',
            align: 'right',
            format: '0'
        },
        {
            text: 'Points Last Season',
            dataIndex: 'points',
            xtype: 'numbercolumn',
            align: 'right',
            format: '0'
        },
        {
            text: 'Salary',
            dataIndex: 'contract',
            xtype: 'numbercolumn',
            align: 'right',
            format: '$0,000'
        }
    ],

    features: [
        {
            ftype: 'grouping',
            groupHeaderTpl: '{name} ({rows.length} Player{[values.rows.length > 1 ? "s" : ""]})',
            hideGroupedHeader: false,
            enableGroupingMenu: false,
            startCollapsed: true,
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
