Ext.define('DynastyDraft.view.ShoutBox', {
    extend: 'Ext.view.View',

    alias: 'widget.shoutbox',
    store: 'Messages',
    itemSelector: 'div.shoutbox_message',
    emptyText: 'No messages to display.',
    autoScroll: true,
    /*listeners: {
        render: {
            element: 'el',
            fn: this.onRenderDone,
        }
    },*/

    _lastScrollHeight: 0,

    initComponent: function() {
        this.tpl = this.getTemplate();
        this.callParent();
    },

    getTemplate: function() {
        var t = new Ext.XTemplate(
            '<tpl for=".">',
                '<div class="shoutbox_message">',
                    '<span class="user_id{[values.action === true ? " action" : ""]}">',
                        '{user}{[values.action === false ? ":" : ""]}',
                    '</span>',
                    '<span class="message{[values.action === true ? " action" : ""]}"> {message}</span>',
                '</div>',
            '</tpl>'
        );
        return t;
    },

    scrollToBottom: function() {
        var e = this.getEl().dom;
        e.scrollTop = e.scrollHeight;
    },

    /*rememberScrollHeight: function() {
        var e = this.getEl().dom;
        console.log(this._lastScrollHeight, this.getHeight());
        this._lastScrollHeight = e.scrollHeight - e.scrollTop;
    },*/
});
