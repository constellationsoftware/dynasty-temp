Ext.define('DynastyDraft.data.Socket', {
    singleton: true,
    alternateClassName: 'Ext.ux.data.Socket',
    mixins: { observable: 'Ext.util.Observable' },

    socket: null,
    connected: false,

    constructor: function() {
        this.addEvents(
            'changeState',
            this.self.STATE_CONNECTING,
            this.self.STATE_CONNECTED,
            this.self.STATE_DISCONNECTED,
            this.self.STATE_UNAVAILABLE,
            this.self.STATE_FAILED
        );

        //Pusher.log = function(m) { console.log(m); };
        Pusher.channel_auth_endpoint = '/draft/auth';
        Pusher.isReady = false;

        if (SOCKET_APP_KEY) {
            // create the socket instance
            this.socket = new Pusher(SOCKET_APP_KEY);
            
            // listen for state changes from pusher
            this.socket.connection.bind('state_change',
                Ext.Function.bind(this.onStateChange, this, null, true));
        } else {
            Ext.Error.raise('Configuration error: Socket key not found!');
        }

        return this;
    },

    /**
     * When the socket is inited, start connecting
     */
    init: function() {
        Pusher.ready();
    },

    subscribe: function(channel, events, scope) {
        scope = scope || null;

        // error checking stuff
        if (!channel || !Ext.isString(channel)) {
            throw new Error('Channel name invalid; expected a non-empty string.');
        }
        if (events && !Ext.isObject(events)) {
            throw new Error('Channel event list invalid; expected an object containing event names as keys and event specification objects as values.')
        }

        var channel = this.socket.subscribe(channel);
        // iterate through the events object and bind the events to this channel
        for (eventName in events) {
            if (events.hasOwnProperty(eventName)) {
                var callback = events[eventName];
                // if no callback was provided
                if (!callback || !Ext.isFunction(callback)) {
                    throw new Error('Event callback missing or invalid.');
                    continue;
                }

                // if an execution scope was provided
                if (Ext.isObject(scope)) {
                    channel.bind(eventName, Ext.Function.bind(callback, scope, null, true));
                } else {
                    channel.bind(eventName, callback);
                }
            }
        }

        return channel;
    },

    request: function(action, data) {
        data = data || {};
        
        // append the socket ID
        data.socket_id = this.getId();

        // for now, just fire off an ajax call
        Ext.Ajax.request({
            url: '/draft/' + action,
            method: 'POST',
            params: data,
            success: function(response) {
                var text = response.responseText;
                console.log(text);
            }
        });
    },

    // states = {previous: 'oldState', current: 'newState'}
    onStateChange: function(state) {
        // change the cached connection status
        this.connected = state.current === this.self.STATE_CONNECTED;

        // notify listeners of the state change
        this.fireEvent('changeState', state.current, state.previous);

        // see if the state matches one of the defined states and fire that as well
        var stateEvent = 'STATE_' + state.current.toUpperCase();
        if (this.self[stateEvent]) { this.fireEvent(this.self[stateEvent]); }
    },

    isConnected: function() {
        return this.connected;
    },

    getId: function() {
        return this.socket.connection.socket_id;
    },

    statics: {
        /* socket connection states */
        STATE_CONNECTING: 'connecting',
        STATE_CONNECTED: 'connected',
        STATE_DISCONNECTED: 'disconnected',
        STATE_UNAVAILABLE: 'unavailable',
        STATE_FAILED: 'failed',
    },
});
