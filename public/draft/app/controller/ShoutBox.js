/**
 * @TODO: Wrap the PUBNUB stuff in an Ext.util.Observable.
 *        Use the wrapper at https://github.com/mrsunshine/Mobile-Chat-with-Sencha-Touch---node.js---socket.io-/blob/master/js/lib/App.util.Socketio.js
 *        as an example.
 *        Also use proper user models when those are avaiable
 */

var PUBNUB_CHANNEL = 'dynasty_test';

Ext.define('DynastyDraft.controller.ShoutBox', {
    extend: 'Ext.app.Controller',
    requires: [ 'Ext.ux.data.Socket' ],
    stores: [ 'Messages' ],
    views: [ 'ShoutBox' ],
    refs: [{
        ref: 'container',
        selector: 'shoutboxcontainer',
    }],

    username: null,

    init: function() {
        var _this = this;
        this.username = "Dynasty-User" + Math.floor(Math.random() * 10000);
        
        this.control({
            'textfield': {
                specialkey: function(field, e) { 
                    if(e.getKey() == e.ENTER) { 
                        var form = field.up('form').getForm();
                        if (form.isValid() && field.getValue()) {
                            // get a store instance and add the message to it
                            var message = this.createMessage(field.getValue());
                            PUBNUB.publish({
                                channel: PUBNUB_CHANNEL,
                                message: message,
                            });
                            field.reset();
                        }
                    } 
                }
            }
        });
        this.getMessagesStore().addListener('datachanged', this.onStoreUpdate, this);

        Ext.ux.data.Socket.subscribe(this.self.CHAT_CHANNEL, {
            'user_join': this.onUserJoined,
        }, this);

        /* 
         * check if connected to socket
         * if so, trigger a join, otherwise defer it until connected
         */
        if (Ext.ux.data.Socket.isConnected()) {
            this.joinChat();
        } else {
            
        }
        
        // LISTEN FOR PUSH MESSAGES
        /*PUBNUB.subscribe({
            // CONNECT TO THIS CHANNEL
            channel: "dynasty_test",

            // LOST CONNECTION (auto reconnects)
            error: function() {
                alert("Lost connection with the chat server.\nTrying to reconnect...");
            },

            // RECEIVED A MESSAGE
            callback: function(message) {
                // add it to the store
                _this.onReceiveMessage.call(_this, message);
            },
            
            // CONNECTION ESTABLISHED
            connect: function() {
                // SEND MESSAGE
                var message = _this.createMessage("has joined", true);

                PUBNUB.publish({
                    channel: PUBNUB_CHANNEL,
                    message: message
                });
            }
        });*/
    },

    joinChat: function() {
        
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

    onReceiveMessage: function(message) {
        // get a store instance and add the message to it
        var store = this.getMessagesStore();
        this.beforeStoreUpdate();
        store.add(message);
    },

    createMessage: function(messageText, action) {
        var message = {
            user: this.username,
            message: messageText,
            action: action,
        };

        return message;
    },

    statics: {
        CHAT_CHANNEL: 'shoutbox',
    },
});
