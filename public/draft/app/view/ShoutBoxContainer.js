Ext.define('DynastyDraft.view.ShoutBoxContainer', {
    extend: 'Ext.panel.Panel',

    alias: 'widget.shoutboxcontainer',
    layout: {
        align: 'stretch',
        type: 'vbox',
        padding: '0 0 2 0'
    },
    items: [
        {
            xtype: 'shoutbox',
            flex: 1
        },
/*
        {
            xtype: 'dataview',
            resizable: true,
            split: true,
            flex: 1,
            width: 100,
            //deferInitialRefresh: true,
            tpl: Ext.create('Ext.XTemplate',
                '<tpl for=".">',
                    '<div class="shoutbox-user {[values.is_online ? "online" : "offline"]}">{name}</div>',
                '</tpl>'
            ),
            itemSelector: '.shoutbox-user',
            minWidth: 100
        }
*/
        {
            xtype: 'form',
            id: 'shoutbox_text_entry',
            border: 0,
            maxWidth: 500,
            resizeable: true,
            items: [
                {
                    xtype: 'textfield',
                    emptyText: 'Type some profanity and hit ENTER',
                    margin: 0,
                    padding: 0,
                    enableKeyEvents: true,
                    anchor: '-2 0'
              }
            ]
        }
    ]
});
