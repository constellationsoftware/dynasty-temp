Ext.define('DynastyDraft.controller.ShoutBox', {
    extend: 'Ext.app.Controller',
    stores: [ 'Messages' ],
    views: [
        'ShoutBoxContainer',
        'ShoutBox'
    ],

    refs: [{
        ref: 'container',
        selector: 'shoutboxcontainer'
    }],

    channel: null,

    init: function() {
        this.control({
            'textfield': {
                specialkey: function(field, e) {
                    if(e.getKey() == e.ENTER) {
                        var form = field.up('form').getForm();
                        if (form.isValid() && field.getValue()) {
                            // get a store instance and add the message to it
                            $.post('draft/send_message', {
                                message: field.getValue()
                            });

                            field.reset();
                        }
                    } 
                }
            }
        });
        JUG.bind('shoutbox:message', Ext.Function.bind(this.onMessageReceived, this));
        this.getMessagesStore().addListener('datachanged', this.onStoreUpdate, this);
    },

    onPick: function(data) {
        var message = this.createMessage(data.user.email, "has picked " + data.player.full_name, true);
        var store = this.getMessagesStore();
        store.add(message);
    },

    joinChat: function() {
        
    },

    onSubscribe: function(data) {
        console.log("subscribed!", data);
    },

    onMessageReceived: function(data) {
        console.log("message received!", data);
        // get a store instance and add the message to it
        var store = this.getMessagesStore();
        this.beforeStoreUpdate();
        store.add(data);
    },

    onUserJoined: function(data) {
        console.log(data);
    },

    // routines to run before the store is updated
    // @TODO: Create an event on this store to do this
    beforeStoreUpdate: function() {
        // find the view for this controller
        /*var result = Ext.ComponentQuery.query('shoutbox');
        try {
            var view = result[0];
            view.rememberScrollHeight.call(view);
        } catch(e) {};*/
    },

    onStoreUpdate: function() {
        var view = this.getContainer().down('shoutbox');
        view.scrollToBottom.call(view);
    },

    createMessage: function(user_id, messageText, action) {
        var message = {
            user: user_id,
            message: messageText,
            action: action,
        };

        return message;
    },

    statics: {
        CHAT_CHANNEL_PREFIX: 'presence-shoutbox-',
    },
});
