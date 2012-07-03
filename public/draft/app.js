Ext.Loader.setConfig({
    enabled: true,
    disableCaching: true,
    paths: { '<appName>': '.', 'Ext': '/assets/extjs/src', 'Ext.ux': '/assets/lib/extjs/ux', 'Ext.override': '/assets/lib/extjs' }
});

var app;
Ext.application({
    name: 'DynastyDraft',
    appFolder: '/draft/app',
    autoCreateViewport: true,

    requires: [
        'DynastyDraft.window.Notification',
        'Ext.window.MessageBox',
        'Ext.override.data.Store',
        'Ext.override.data.proxy.Server',
        'Ext.override.data.reader.Json',
        'Ext.data.SequentialIdGenerator',
        'Ext.layout.container.Border',
        'Ext.tab.Panel',
        'Ext.form.field.ComboBox',
        'Ext.grid.column.Number',
        'Ext.grid.RowNumberer',
        'Ext.grid.PagingScroller',
        'Ext.grid.feature.Grouping',
        'Ext.form.Panel'
    ],

    models: [
        'Update'
    ],

    controllers: [
        'Ext.ux.util.AlwaysOnTop',
        'PlayerGrid',
        'Roster',
        'AdminControls',
        'Picks',
        'RecommendedPicks',
        'DraftBoard',
        'ShoutBox'
    ],

    launch: function() {
        window.app = this;

        Ext.getBody().removeCls('loading');
        if (DRAFT_STATE === 'finished') { this.showDraftFinishedDialog(); }

        // Attach countdown timer to countdown_wrap container
        countdown = new Countdown('#countdown-wrap');
        duration = 180;
        this.addListener(this.STATUS_PICKING, function() { this.start(duration) }, countdown);
        this.addListener(this.STATUS_PICKED, countdown.clear, countdown);
        this.addListener(this.STATUS_PAUSED, countdown.resume, countdown);
        this.addListener(this.STATUS_RESUMED, countdown.pause, countdown);
        this.addListener(this.STATUS_RESET, countdown.clear, countdown);
        this.addListener(this.LIVE_PICK_MADE, function() { this.start(duration) }, countdown);
        this.addListener(this.STATUS_STARTED, function() { this.start(duration) }, countdown);
        this.addListener(this.PICK_UPDATE, countdown.clear, countdown);
        countdown.bind('timeout', Ext.Function.bind(this.onTimeout, this));
        window.countdown = countdown;

        Ext.tip.QuickTipManager.init();
        Ext.apply(Ext.tip.QuickTipManager.getQuickTip(), {
            showDelay: 50      // Show 50ms after entering target
        });

        JUG.bind('draft:starting', Ext.Function.bind(this.onStarting, this));
        JUG.bind('draft:on-deck', Ext.Function.bind(this.onDeck, this));
        JUG.bind('draft:picking', Ext.Function.bind(this.onTeamPicking, this)); // other teams
        JUG.bind('draft:picked', Ext.Function.bind(this.onTeamPicked, this));
        JUG.bind('draft:finished', Ext.Function.bind(this.onDraftFinish, this));
        JUG.bind('draft:reset', Ext.Function.bind(this.onDraftReset, this));

        // this.getController('Timer').addListener('timeout', this.onTimeout, this);
        this.getController('RecommendedPicks').addListener('playerpicked', this.onPick, this);
        this.getController('Picks').addListener('picksucceeded', this.onPickSucceeded, this);
    },

    onStarting: function() {
        this.fireEvent(this.STATUS_STARTING);
    },

    onDeck: function(data) {
        console.log(data);
        this.fireEvent(this.STATUS_PICKING, data);
    },

    onTeamPicking: function(payload) {
        this.fireEvent(this.LIVE_PICK_MADE);
    },

    onPick: function(player) { // when the client makes a pick
        console.log('player picked succeeded', player);
        this.fireEvent(this.STATUS_PICKED, player.get('id'));
    },

    onTeamPicked: function(payload) { // when another team makes a pick
        // show notification bubble for pick
        var msg = payload.team.name + " picked " + payload.player.name + ".";
        App.Notification.notify(msg);

        // display pick in the shoutbox
        var store = window.ShoutboxMessages;
        var model = store.model;
        if (model) {
            var record = model.create({
                user: payload.team.name,
                message: "picked " + payload.player.name,
                type: 'notice'
            });
            console.log(record);
            store.add(record);
        }

        this.fireEvent(this.PICK_UPDATE, payload.pick);
    },

    onDraftFinish: function() {
        this.showDraftFinishedDialog();
        this.fireEvent(this.STATUS_FINISHED);
    },

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

    onPickSucceeded: function() {
        this.fireEvent(this.STATUS_PICK_SUCCESS);
        this.fireEvent(this.STATUS_WAITING);
    },

    onPlayerPickFailed: function() {
        console.log('player pick failed');
        this.fireEvent(this.STATUS_WAITING);
    },

    onTimeout: function() {
        this.fireEvent(this.TIMEOUT);
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
        STATUS_STARTING:        'starting',
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
        PICK_UPDATE:            'pick_update'
    //}
});
