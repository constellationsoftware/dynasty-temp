/**
 * @TODO: Wrap the PUBNUB stuff in an Ext.util.Observable.
 *        Use the wrapper at https://github.com/mrsunshine/Mobile-Chat-with-Sencha-Touch---node.js---socket.io-/blob/master/js/lib/App.util.Socketio.js
 *        as an example.
 *        Also use proper user models when those are avaiable
 */

var PUBNUB_CHANNEL = 'dynasty_test';

Ext.define('DynastyDraft.controller.ShoutBox', {
    extend: 'Ext.app.Controller',
    stores: [ 'Messages' ],
    username: null,

    init: function() {
        var _this = this;

        this.username = "Dynasty-User" + Math.floor(Math.random() * 10000);
        
        this.control({
            '#shoutbox_text_entry > textfield': {
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
        //this.getMessagesStore().addListener('datachanged', this.onStoreUpdate, this);
        
        // LISTEN FOR PUSH MESSAGES
        PUBNUB.subscribe({
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
        });
    },

    /*
    onStoreUpdate: function() {
        var views = Ext.ComponentQuery.query('shoutbox');
        try {
            var view = views[0];
            view.scrollToBottom.call(view);
        } catch(e) {};
    },
    */

    onReceiveMessage: function(message) {
        // get a store instance and add the message to it
        this.getMessagesStore().add(message);
    },

    createMessage: function(messageText, action) {
        var message = {
            user: this.username,
            message: messageText,
            action: action,
        };

        return message;
    },
});
