Ext.define('DynastyDraft.view.Roster', {
    extend: 'Ext.grid.Panel',
    // uncomment to enable empty grouping
    // WARNING: does not work entirely
    //requires: [ 'DynastyDraft.grid.feature.Grouping' ],

    alias: 'widget.roster',
    title: 'Roster',
    store: 'Roster',
    columnLines: true,

    columns: [
        {
            text: 'Depth',
            dataIndex: 'depth',
            xtype: 'gridcolumn',
            hideable: false,
            groupable: false,
            flex: 0.15,
        },
        {
            text: 'Player Name',
            dataIndex: 'full_name',
            xtype: 'gridcolumn',
            hideable: false,
            groupable: true,
            flex: 1,
        },

        {
            text: 'Team',
            dataIndex: 'team_name',
            xtype: 'gridcolumn',
            align: 'right',
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
            dataIndex: 'contract',
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
