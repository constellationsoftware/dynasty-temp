/**
 * @TODO: Wrap the PUBNUB stuff in an Ext.util.Observable.
 *        Use the wrapper at https://github.com/mrsunshine/Mobile-Chat-with-Sencha-Touch---node.js---socket.io-/blob/master/js/lib/App.util.Socketio.js
 *        as an example.
 *        Also use proper user models when those are avaiable
 */

var PUBNUB_CHANNEL = 'dynasty_test';

Ext.define('DynastyDraft.controller.ShoutBox', {
    extend: 'Ext.app.Controller',
    requires: [ 'DynastyDraft.data.Socket' ],
    stores: [ 'Messages' ],
    views: [ 'ShoutBox' ],
    refs: [{
        ref: 'container',
        selector: 'shoutboxcontainer',
    }],

    channel: null,

    init: function() {
        var _this = this;
        
        this.control({
            'textfield': {
                specialkey: function(field, e) {
                    if(e.getKey() == e.ENTER) {
                        var form = field.up('form').getForm();
                        if (form.isValid() && field.getValue()) {
                            // get a store instance and add the message to it
                            var message = this.createMessage(user.email, field.getValue());
                            Ext.ux.data.Socket.request('post_message', {
                                message: message.message,
                            });

                            field.reset();
                        }
                    } 
                }
            }
        });
        this.getMessagesStore().addListener('datachanged', this.onStoreUpdate, this);

        var channel = Ext.ux.data.Socket.subscribe(this.self.CHAT_CHANNEL_PREFIX + this.application.getSubDomain(), {
            'send_message': this.onMessageReceived,
        }, this);

        /* 
         * check if connected to socket
         * if so, trigger a join, otherwise defer it until connected
         */
        if (Ext.ux.data.Socket.isConnected()) {
            this.joinChat();
        } else {
            
        }
    },

    onPick: function(data) {
        console.log(data);
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
