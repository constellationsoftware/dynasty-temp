Ext.define('DynastyDraft.view.PlayerGrid', {
    extend: 'Ext.grid.Panel',

    alias: 'widget.playergrid',
    autoScroll: true,
    overlapHeader: true,
    title: 'Players',
    store: 'Players',
    columnLines: true,

    initComponent: function() {
        this.viewConfig = {
            plugins: [
                {
                    ptype: 'gridviewdragdrop',
                    dragText: 'Drop onto your team roster',
                    dragGroup: 'PlayerGridDD',
                    enableDrop: false,
                },
            ],
        };

        this.columns = [
            {
                text: 'Name',
                dataIndex: 'name',
                xtype: 'gridcolumn',
                width: 114,
                layout: {
                    type: 'fit'
                },
                fixed: true,
                hideable: false,
                groupable: true,
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
            /*
            {
                xtype: 'gridcolumn',
                hidden: true,
                dataIndex: 'position',
                fixed: true,
                text: 'Position'
            },
            {
                xtype: 'numbercolumn',
                dataIndex: 'comp',
                text: 'Comp'
            },
            {
                xtype: 'numbercolumn',
                dataIndex: 'pass_yards',
                text: 'Pass Yards'
            },
            {
                xtype: 'numbercolumn',
                dataIndex: 'interceptions',
                text: 'Interceptions',
                format: '0,000'
            },
            {
                xtype: 'numbercolumn',
                itemId: 'Rush Yards',
                dataIndex: 'rush_yards',
                text: 'Rush Yards'
            },
            {
                xtype: 'numbercolumn',
                itemId: 'Rush TD',
                dataIndex: 'rush_td',
                text: 'Rush TD'
            }
            */
        ];
        /*this.selModel = Ext.create('Ext.selection.RowModel', {
            allowDeselect: true
        });*/

        var groupingFeature = Ext.create('Ext.grid.feature.Grouping',{
            groupHeaderTpl: 'Position: {name} ({rows.length} Player{[values.rows.length > 1 ? "s" : ""]})'
        });

        this.features = [
            {
                ftype: 'rowbody'
            },
            groupingFeature,
        ];

        this.tbar = [
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
       ];

        this.callParent();
    }
});
