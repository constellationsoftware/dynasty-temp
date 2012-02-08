Ext.Loader.setConfig({
    enabled: true,
    disableCaching: true,
    //paths: { '<appName>': '.', 'Ext': '/draft/lib/extjs/src', 'Ext.ux': '/draft/lib/extjs/ux' }
});

var app;
Ext.application({
    name: 'DynastyDraft',
    appFolder: '/draft/app',
    autoCreateViewport: true,

    requires: [
        'DynastyDraft.data.Socket',
        'Ext.window.MessageBox'
    ],

    models: [
        'Update'
    ],

    stores: [
        //'PlayerStoreCharts',
        'Roster',
        'Players',
        'Picks',
    ],

    controllers: [
        'PlayerGrid',
        'Timer',
        'Roster',
        'AdminControls',
        'Picks',
        'RecommendedPicks'
    ],

    launch: function() {
        app = this;
        Ext.getBody().removeCls('loading');
        if (DRAFT_STATUS === 'finished') { this.showDraftFinishedDialog(); }

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
            'draft:finish': this.onDraftFinish,
            'draft:reset': this.onDraftReset,
            'draft:pick:start': this.onDraftLivePick
        };
        events['draft:pick:start-' + CLIENT_ID] = this.startPicking;
        events['draft:pick:resume-' + CLIENT_ID] = this.resumePicking;

        DynastyDraft.data.Socket.subscribe(this.LEAGUE_CHANNEL_PREFIX + this.getSubDomain(), events, this);

        // initialize the socket service
        DynastyDraft.data.Socket.init();

        this.getController('Timer').addListener('timeout', this.onTimeout, this);
        this.getController('RecommendedPicks').addListener('playerpicked', this.onPlayerPicked, this);
        this.getController('AdminControls').addListener('click', this.onAdminControlsClicked, this);
        this.getController('Picks').addListener('picksucceeded', this.onPickSucceeded, this);
    },

    onDraftLivePick: function(payload){
        console.log(payload);
        this.fireEvent(this.LIVE_PICK_MADE);
    },

    onDraftFinish: function() {
        this.showDraftFinishedDialog();
        this.fireEvent(this.STATUS_FINISHED);
    },

    onAdminControlsClicked: function(button) {
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
            this.reset();
            break;
        }
    },

    reset: function() {
        Ext.ux.data.Socket.request('reset');
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
        var t = setTimeout('window.location.reload()', 5000);
        Ext.Msg.show({
            title: 'The draft has been reset!',
            msg: 'An administrator has initiated a draft reset. ' +
                'The page will refresh in 5 seconds. ' +
                'Press the button below if you do not wish to wait.',
            icon: Ext.Msg.WARNING,
            buttons: Ext.MessageBox.OK,
            width: 400,
            fn: function() {
                clearTimeout(t);
                window.location.reload();
            }
        });
    },

    onPlayerPicked: function(player) {
        console.log('player picked succeeded', player);
        this.fireEvent(this.STATUS_PICKED, player.get('id'));
        //Ext.ux.data.Socket.request('pick', { player_id: player.get('id') });
    },

    onPickSucceeded: function() {
        this.fireEvent(this.STATUS_PICK_SUCCESS);
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
        var player_id = data.player_id;
        this.fireEvent(this.PICK_UPDATE, data);
    },

    onTimeout: function() {
        this.fireEvent(this.TIMEOUT);
    },

    onDraftJoin: function(member_list) {
        console.log('Joined draft sucessfully');
        //Ext.ux.data.Socket.request('ready', { id: user.id });
    },

    startPicking: function(data) {
        this.fireEvent(this.STATUS_PICKING, data);
    },

    resumePicking: function() {
        this.fireEvent(this.STATUS_RESUMED);
    },

    getSubDomain: function() {
        var a = window.location.host.split('.');
        return a[0];
    },

    showDraftFinishedDialog: function() {
        Ext.Msg.show({
            title: '',
            msg: 'The draft is complete!',
            icon: Ext.Msg.WARNING,
            buttons: Ext.MessageBox.OK,
            fn: function() {
                window.location = 'http://' + window.location.host + '/';
            }
        });
    },

    //statics: {
        STATUS_STARTED:         'started',
        STATUS_PICKING:         'picking',
        STATUS_PICKED:          'picked',
        STATUS_PICK_SUCCESS:    'picksuccess',
        STATUS_WAITING:         'waiting',
        STATUS_PAUSED:          'paused',
        STATUS_RESUMED:         'resumed',
        STATUS_RESET:           'reset',
        STATUS_FINISHED:        'finished',
        LIVE_PICK_MADE:         'someone-made-a-pick',

        TIMEOUT:                'timeout',

        LEAGUE_CHANNEL_PREFIX:  'presence-draft-',
        PICK_UPDATE:            'pick_update',
    //}
});
