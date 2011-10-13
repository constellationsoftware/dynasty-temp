Ext.define('DynastyDraft.view.ShoutBox', {
    extend: 'Ext.view.View',

    alias: 'widget.shoutbox',
    store: 'Messages',
    itemSelector: 'div.shoutbox_message',
 
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
        list.scroller.updateBoundary();
        list.scroller.scrollTo({x: 0, y:list.scroller.size.height}, true);
    }
});
