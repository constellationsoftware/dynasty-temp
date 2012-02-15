Ext.define('DynastyDraft.view.ShoutBox', {
    extend: 'Ext.view.View',

    alias: 'widget.shoutbox',
    store: 'Messages',
    itemSelector: 'div.shoutbox_message',
    emptyText: 'No messages to display.',
    autoScroll: true,

    tpl: new Ext.XTemplate(
        '<tpl for=".">',
            '<div class="shoutbox_message {type}">',
                '<tpl if="type == &quot;text&quot;"><span class="user_id">{user}</span><span>{message}</span></tpl>',
                '<tpl if="type == &quot;notice&quot;"><span>{user} {message}</span></tpl>',
            '</div>',
        '</tpl>'
    ),

    scrollToBottom: function() {
        var e = this.getEl().dom;
        e.scrollTop = e.scrollHeight;
    }

/*
    _lastScrollHeight: 0,
    rememberScrollHeight: function() {
        var e = this.getEl().dom;
        console.log(this._lastScrollHeight, this.getHeight());
        this._lastScrollHeight = e.scrollHeight - e.scrollTop;
    }
*/
});
