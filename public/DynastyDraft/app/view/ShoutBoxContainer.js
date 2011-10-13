Ext.define('DynastyDraft.view.ShoutBoxContainer', {
    extend: 'Ext.container.Container',
    requires: [ 'DynastyDraft.view.ShoutBox' ],

    alias: 'widget.shoutboxcontainer',
    activeItem: 0,
    layout: {
        type: 'absolute'
    },

    initComponent: function() {
        this.items = [
            {
                xtype: 'shoutbox',
                anchor: '100%',
                x: 0,
                y: 0,
            },
            {
                xtype: 'textfield',
                emptyText: 'Send a message...',
                anchor: '-5',
                x: 5,
                y: 5,
            },
        ];
        this.callParent();
    }
});
