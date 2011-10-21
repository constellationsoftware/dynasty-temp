Ext.define('DynastyDraft.view.PlayerGrid', {
    extend: 'Ext.grid.Panel',

    alias: 'widget.playergrid',
    title: 'Players',
    store: 'Players',
    columnLines: true,
    selModel: {
        mode: "MULTI",
    },
    viewConfig: {
        plugins: [
            {
                ptype: 'gridviewdragdrop',
                dragText: 'Drop onto your team roster',
                dragGroup: 'PlayerGridDD',
                enableDrop: false,
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
            text: 'Dynasty Rank',
            dataIndex: 'fan_points',
            xtype: 'numbercolumn',
            align: 'right',
            format: '0.00',
        },
        {
            text: 'Rating',
            dataIndex: 'rating',
            xtype: 'numbercolumn',
            align: 'right',
            format: '0.00',
        },
        {
            text: 'Salary',
            dataIndex: 'salary',
            id: 'Salary',
            xtype: 'numbercolumn',
            align: 'right',
            format: '0,000',
            /*renderer: function(value) {
                return Ext.util.Format.currency(value, null, 2);
            },*/
        },
    ],

    features: [
        {
            ftype: 'rowbody'
        },
        {
            ftype: 'grouping',
            groupHeaderTpl: '{name} ({rows.length} Player{[values.rows.length > 1 ? "s" : ""]})',
            hideGroupedHeader: false,
            enableGroupingMenu: false,
            startCollapsed: false,
        }
    ],

    /*
    this.tbar: [
        {
            xtype: 'button',
            text: 'QB',
            enableToggle: true,
            pressed: true,
        },
        {
            xtype: 'button',
            text: 'RB',
            enableToggle: true,
            pressed: true,
        },
        {
            xtype: 'button',
            text: 'WR',
            enableToggle: true,
            pressed: true,
        },
   ],
   */
});
