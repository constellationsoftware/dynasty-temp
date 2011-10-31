Ext.define('DynastyDraft.data.Socket', {
    singleton: true,
    alternateClassName: 'Ext.ux.data.Socket',
    mixins: { observable: 'Ext.util.Observable' },

    socket: null,
    _connected: false,

    config: {},

    constructor: function(config) {
        var me = this;
        me.initConfig(config);

        me.addEvents(
            'changeState',
            me.self.STATE_CONNECTING,
            me.self.STATE_CONNECTED,
            me.self.STATE_DISCONNECTED,
            me.self.STATE_UNAVAILABLE,
            me.self.STATE_FAILED
        );

        Pusher.channel_auth_endpoint = '/api/auth';
        me.socket = new Pusher(me.self.API_KEY);
        
        // listen for state changes from pusher
        me.socket.connection.bind('state_change',
            function() { // bind "this" to our callbacks
                me.onStateChange.apply(me, arguments);
                return this;
            }
        );
    },

    subscribe: function(channel, events, scope) {
        scope = scope || null;

        // error checking stuff
        if (!channel || Ext.isString(channel)) {
            throw new Error('Channel name invalid; expected a non-empty string.');
        }
        if (!events || Ext.isObject(events)) {
            throw new Error('Channel event list invalid; expected an object containing event names as keys and event specification objects as values.')
        }

        var channel = this.socket.subscribe(channel);
        // iterate through the events object and bind the events to this channel
        events.each(function(eventName, callback) {
            // if no callback was provided
            if (!callback || !Ext.isFunction(callback)) {
                throw new Error('Event callback missing or invalid.');
                continue;
            }

            // if an execution scope was provided
            if (Ext.isObject(scope)) {
                channel.bind(eventName, callback.apply(scope));
            } else {
                channel.bind(eventName, callback);
            }
        }, this);

        return this;
    },

    request: function() {
        
    },

    // states = {previous: 'oldState', current: 'newState'}
    onStateChange: function(state) {
        console.log("Socket status: " + state.current);

        // change the cached connection status
        this._connected = state.current === STATE_CONNECTED;

        // notify listeners of the state change
        this.fireEvent('changeState', state.current, state.previous);

        // see if the state matches one of the defined states and fire that as well
        var stateEvent = 'STATE_' + state.current.toUpperCase();
        if (this.self[stateEvent]) { this.fireEvent(stateEvent); }
    },

    isConnected: function() {
        return this._connected;
    },

    statics: {
        API_KEY: '64db7a76d407adc40ff3',

        /** socket connection states */
        STATE_CONNECTING: 'connecting',
        STATE_CONNECTED: 'connected',
        STATE_DISCONNECTED: 'disconnected',
        STATE_UNAVAILABLE: 'unavailable',
        STATE_FAILED: 'failed',
    },
});
