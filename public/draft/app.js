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
        'AdminControls',
    ],

    launch: function() {
        Ext.tip.QuickTipManager.init();
        Ext.apply(Ext.tip.QuickTipManager.getQuickTip(), {
            showDelay: 50      // Show 50ms after entering target
        });
        
        // subscribe to a global "draft events" channel
        var events = {
            'pusher:subscription_succeeded': this.onDraftJoin,
            'draft:pick:update': this.onPickUpdate,
            //'draft:pause': this.onDraftPaused,
            //'draft:resume': this.onDraftResumed,
            'draft:reset': this.onDraftReset,
        };
        events['draft:pick:start-' + CLIENT_ID] = this.startPicking;
        events['draft:pick:resume-' + CLIENT_ID] = this.resumePicking;

        DynastyDraft.data.Socket.subscribe(this.LEAGUE_CHANNEL_PREFIX + this.getSubDomain(), events, this);

        // initialize the socket service
        DynastyDraft.data.Socket.init();

        this.getController('Timer').addListener('timeout', this.onTimeout, this);
        this.getController('PlayerQueue').addListener('picked', this.onPlayerPicked, this);
        this.getController('PlayerQueue').addListener('pickfailed', this.onPlayerPickFailed, this);
        this.getController('AdminControls').addListener('click', this.onAdminControlsClicked, this);
    },

    onAdminControlsClicked: function(button) {
        console.log(button);
        switch (button.getItemId()) {
        case 'start':
            Ext.ux.data.Socket.request('start');
            break;
        case 'pause':
            if (button.getText() === 'Stop Countdown') {
                this.fireEvent(this.STATUS_PAUSED);
                //Ext.ux.data.Socket.request('halt');
            } else {
                this.fireEvent(this.STATUS_RESUMED);
                //Ext.ux.data.Socket.request('resume');
            }
            break;
        case 'reset':
            Ext.ux.data.Socket.request('reset');
            break;
        }
    },

    /*
    onDraftPaused: function(data) {
        this.fireEvent(this.STATUS_PAUSED);
    },

    onDraftResumed: function(data) {
        this.fireEvent(this.STATUS_RESUMED);
    },
    */
    
    onDraftReset: function(data) {
        this.fireEvent(this.STATUS_RESET);
    },

    onPlayerPicked: function(player) {
        console.log('player pick succeeded', player);
        this.fireEvent(this.STATUS_PICKED, player.get('id'));
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
    onPickUpdate: function(data) {
        console.log("pick update received", data);
        var pick_id = data.player_id;
        this.fireEvent(this.PICK_UPDATE, pick_id);
    },

    onTimeout: function() {
        this.fireEvent(this.TIMEOUT);
    },

    onDraftJoin: function(member_list) {
        console.log('Joined draft sucessfully');
        //Ext.ux.data.Socket.request('ready', { id: user.id });
    },

    startPicking: function() {
        console.log("my turn to pick YAY");
        this.fireEvent(this.STATUS_BEFORE_PICKING);
        this.fireEvent(this.STATUS_PICKING);
    },

    resumePicking: function() {
        console.log("my turn to pick YAY");
        this.fireEvent(this.STATUS_RESUMED);
    },


    getSubDomain: function() {
        var a = window.location.host.split('.');
        return a[0];
    },

    //statics: {
        STATUS_STARTED:         'started',
        STATUS_BEFORE_PICKING:  'beforepick',
        STATUS_PICKING:         'picking',
        STATUS_PICKED:          'picked',
        STATUS_WAITING:         'waiting',
        STATUS_PAUSED:          'paused',
        STATUS_RESUMED:         'resumed',
        STATUS_RESET:           'reset',

        TIMEOUT:                'timeout',

        LEAGUE_CHANNEL_PREFIX:  'presence-draft-',
        PICK_UPDATE:            'pick_update',
    //}
});
