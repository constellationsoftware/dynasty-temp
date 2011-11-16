Ext.Loader.setConfig({
    enabled: true,
    disableCaching: true,
    //paths: { '<appName>': '.', 'Ext': '/draft/lib/extjs/src', 'Ext.ux': '/draft/lib/extjs/ux' }
});



Ext.application({
    name: 'DynastyDraft',
    appFolder: '/draft/app',
    autoCreateViewport: true,

    requires: [ 'DynastyDraft.data.Socket' ],

    models: [
        'Message',
        'Update'

    ],

    stores: [
        //'PlayerStoreCharts',
        'Messages',
        'Salaries',
        'Roster',
    ],

    controllers: [
        'PlayerGrid',
        'PlayerQueue',
        'ShoutBox',
        'Timer',
        'Roster',
    ],

    launch: function() {
        Ext.tip.QuickTipManager.init();
        Ext.apply(Ext.tip.QuickTipManager.getQuickTip(), {
            showDelay: 50      // Show 50ms after entering target
        });

        var events = {
            'pusher:subscription_succeeded': this.onDraftJoin,
            'draft:pick:received': this.onPickReceived
        };
        events['draft:pick:user_' + user.id] = this.myTurnToPick;
        // subscribe to a "draft events" channel
        DynastyDraft.data.Socket.subscribe(this.LEAGUE_CHANNEL, events, this);
        DynastyDraft.data.Socket.subscribe('presence-draft-' + DRAFT_ID);

        // initialize the socket service
        DynastyDraft.data.Socket.init();

        this.getController('Timer').addListener('timeout', this.onTimeout, this);
        this.getController('PlayerQueue').addListener('picked', this.onPlayerPicked, this);
        this.getController('PlayerQueue').addListener('pickfailed', this.onPlayerPickFailed, this);
    },

    onPlayerPicked: function(player) {
        console.log('player pick succeeded', this);
        this.fireEvent(this.STATUS_PICKED, player);
        Ext.ux.data.Socket.request('pick', { player_id: player.get('id') });
        this.fireEvent(this.STATUS_WAITING);
    },

    onPlayerPickFailed: function() {
        console.log('player pick failed');
        this.fireEvent(this.STATUS_WAITING);
    },

    /*
     * When a pick event originated from someone else is received
     */
    onPickReceived: function(data) {
        console.log("pick received", data);
        var player = data.player;
        this.fireEvent(this.LEAGUE_PICK, player);
    },

    onTimeout: function() {
        this.fireEvent(this.TIMEOUT);
    },

    onDraftJoin: function(member_list) {
        Ext.ux.data.Socket.request('ready', { id: user.id });
    },

    myTurnToPick: function() {
        console.log("my turn to pick YAY");
        this.fireEvent(this.STATUS_BEFORE_PICKING);
        this.fireEvent(this.STATUS_PICKING);
    },

    //statics: {
        STATUS_BEFORE_PICKING:  'beforepick',
        STATUS_PICKING:         'picking',
        STATUS_PICKED:          'picked',
        STATUS_WAITING:         'waiting',

        TIMEOUT:                'timeout',

        LEAGUE_CHANNEL:         'presence-draft',
        LEAGUE_BEFORE_PICK:     'before_remote_pick',
        LEAGUE_PICK:            'remote_pick',
        LEAGUE_AFTER_PICK:      'after_remote_pick',
    //}
});
