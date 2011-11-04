Ext.define('DynastyDraft.view.PlayerGrid', {
    extend: 'Ext.grid.Panel',

    alias: 'widget.playergrid',
    title: 'Players',
    store: 'Salaries',
    columnLines: true,
    selModel: {
        mode: "MULTI",
    },
    verticalScrollerType: 'paginggridscroller',
    loadMask: true,
    invalidateScrollerOnRefresh: false,
    viewConfig: {
        copy: true,
        trackOver: false,
        getRowClass: function(record, rowIndex, rowParams, store) {
            if (!record.get('valid')) { return 'row-invalid'; }
        },
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
            dataIndex: 'full_name',
            xtype: 'gridcolumn',
            hideable: false,
            groupable: true,
            flex: 1,
        },
        {
            text: 'Points',
            dataIndex: 'points',
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
            text: 'Consistency',
            dataIndex: 'consistency',
            xtype: 'numbercolumn',
            align: 'right',
            format: '0.00',
        },
        {
            text: 'Salary',
            dataIndex: 'contract_amount',
            xtype: 'numbercolumn',
            align: 'right',
            format: '0,000',
            /*renderer: function(value) {
                return Ext.util.Format.currency(value, null, 2);
            },*/
        },
        {
            text: 'Position',
            dataIndex: 'position',
            xtype: 'gridcolumn',
            align: 'right',
            width: 50,
            sortable: false,
        }
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
