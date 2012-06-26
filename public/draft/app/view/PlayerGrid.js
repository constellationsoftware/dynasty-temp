Ext.define('DynastyDraft.view.PlayerGrid', {
    extend: 'Ext.grid.Panel',

    alias: 'widget.playergrid',
    title: 'Players',
    store: 'Players',
    columnLines: true,
    selModel: "SINGLE",
    verticalScrollerType: 'paginggridscroller',
    loadMask: true,
    invalidateScrollerOnRefresh: false,
    viewConfig: {
        trackOver: false,
        getRowClass: function(record) {
            if (record.get('team') > 0) { return 'row-invalid'; }
        }
    },

    tbar: [{
        xtype: 'textfield',
        itemId: 'search',
        name: 'searchField',
        fieldLabel: 'Search',
        labelWidth: 50,
        emptyText: 'Enter a player\'s first or last name',
        width: 250
    }, {
        xtype: 'button',
        itemId: 'available',
        enableToggle: true,
        text: 'Hide Unavailable'
    }],

    columns: [{
        xtype: 'rownumberer',
        width: 40,
        sortable: false
    }, {
        text: 'Liked',
        dataIndex: 'favorite',
        width: 45,
        align: 'center',
        renderer: function(value, metadata, record) {
            return value > 0 ? '<img src="/draft/resources/images/icons/silk/heart.png" />' : '';
        }
    }, {
        text: 'First Name',
        dataIndex: 'first_name',
        xtype: 'gridcolumn',
        flex: 1
    }, {
        text: 'Last Name',
        dataIndex: 'last_name',
        xtype: 'gridcolumn',
        flex: 1
    }, {
        text: 'Position',
        dataIndex: 'position',
        xtype: 'gridcolumn',
        align: 'right',
        width: 50
    }, {
        text: 'Points',
        dataIndex: 'points',
        xtype: 'numbercolumn',
        align: 'right',
        format: '0.00',
        flex: 1
    }, {
        text: 'Contract',
        dataIndex: 'contract',
        xtype: 'numbercolumn',
        align: 'right',
        format: '0,000',
        flex: 1,
        renderer: function(value) { return Ext.util.Format.currency(value, null, 2); }
    }, {
        text: 'DD/P',
        dataIndex: 'dollars_per_point',
        align: 'right',
        xtype: 'numbercolumn',
        format: '0.0',
        flex: 1,
        sortable: false
    }]
});
