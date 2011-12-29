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
            text: 'Name',
            dataIndex: 'full_name',
            xtype: 'gridcolumn',
            hideable: false,
            groupable: true,
            flex: 1,
        },
        {
            text: 'Salary',
            dataIndex: 'contract_amount',
            xtype: 'numbercolumn',
            align: 'right',
            format: '0,000',
        },
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
