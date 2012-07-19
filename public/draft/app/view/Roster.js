Ext.define('DynastyDraft.view.Roster', {
    extend: 'Ext.grid.Panel',
    // uncomment to enable empty grouping
    // WARNING: does not work entirely
    //requires: [ 'DynastyDraft.grid.feature.Grouping' ],

    alias: 'widget.roster',
    title: 'Roster',
    store: 'Roster',
    columnLines: false,

    columns: [{
        text: 'Position',
        dataIndex: 'position',
        xtype: 'gridcolumn',
        hideable: false,
        groupable: false,
        flex: 0.15
    }, {
        text: 'Depth',
        dataIndex: 'string',
        xtype: 'gridcolumn',
        hideable: false,
        groupable: false,
        flex: 0.15,
        renderer: function(value) {
            switch(value) {
                case 1: return 'Starter';
                case 2: return 'Bench';
                case 3: return 'Injured/Reserve';
                default: return '';
            }
        }
    }, {
        text: 'Player Name',
        dataIndex: 'full_name',
        xtype: 'gridcolumn',
        hideable: false,
        groupable: true,
        flex: 1
    }, {
        text: 'Bye Week',
        dataIndex: 'bye_week',
        xtype: 'numbercolumn',
        align: 'right',
        format: '0'
    }]
});
