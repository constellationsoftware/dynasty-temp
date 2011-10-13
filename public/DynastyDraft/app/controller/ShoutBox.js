Ext.define('DynastyDraft.controller.ShoutBox', {
    extend: 'Ext.app.Controller',
    stores: [ 'Messages' ],

    init: function() {
        this.control({
            /*'shoutbox': {
                
            }*/
        });

        /**
         * Add custom event listener
         */
        this.getMessagesStore().addListener('datachanged', this.onStoreUpdate, this);
        
        var _this = this;
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
                _this.onMessageReceived.call(_this, message);
            },
            
            // CONNECTION ESTABLISHED
            connect: function() {
                // SEND MESSAGE
                var message = {
                    user: "Dynasty User",
                    message: "has joined",
                    action: true
                };
                for (i = 0; i < 10; i++) {
                PUBNUB.publish({
                    channel: "dynasty_test",
                    message: message
                });
                }
            }
        });
    },

    onMessageReceived: function(message) {
        // get a store instance and add the message to it
        this.getMessagesStore().add(message);
    },

    onStoreUpdate: function() {
        var views = Ext.ComponentQuery.query('shoutbox');
        try {
            var view = views[0];
            view.scrollToBottom.call(view);
        } catch(e) {};
    }
});
