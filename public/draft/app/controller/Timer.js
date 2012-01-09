Ext.define('DynastyDraft.controller.Timer', {
    extend: 'Ext.app.Controller',

    views: [ 'Timer' ],

    view: null,
    countdown: null,
    taskRunner: null,

    init: function() {
        this.control({
            'timer': {
                render: this.onViewRender
            },
        });

        this.addEvents('timeout');

        this.taskRunner = new Ext.util.TaskRunner();
        this.application.addListener(this.application.STATUS_PICKING, this.start, this);
        this.application.addListener(this.application.STATUS_PICKED, this.reset, this);
        this.application.addListener(this.application.STATUS_PAUSED, this.pause, this);
        this.application.addListener(this.application.STATUS_RESUMED, this.resume, this);
        this.application.addListener(this.application.STATUS_RESET, this.reset, this);
    },

    pause: function() {
        this.taskRunner.stop(this.countdown);
    },

    resume: function() {
        console.log("resuming");
        this.taskRunner.start(this.countdown);
    },

    reset: function() {
        // stop the timer
        try {
            this.taskRunner.stop(this.countdown);
        } catch (e) {}
        this.view.updateTimer(0, 0);
        this.countdown = null;
    },

    onTimeout: function() {
        // stop the timer
        this.reset();

        // notify listeners that the timer ran out
        this.fireEvent('timeout');

        //this.taskRunner.start(this.countdown);
    },

    start: function() {
        if (this.countdown === null) {
            // init the timer countdown task
            this.countdown = {
                run: function(iterations) {
                    // stop the task when the timer reaches 0
                    var count = this.self.TURN_LENGTH - ((iterations - 1) % (this.self.TURN_LENGTH + 1));
                    
                    // split seconds into minutes and seconds
                    var minutes = Math.floor(count / 60);
                    var seconds = count % 60;

                    // update the view to show the remaining time
                    this.view.updateTimer(minutes, seconds);

                    // when the timer times out
                    if (count === 0) { this.onTimeout(); }
                },
                interval: 1000,
                args: null,
                scope: this
            };

            this.taskRunner.start(this.countdown);
        }
    },

    onViewRender: function(view) {
        this.view = view;
        this.view.updateTimer(0, 0);
    },

    statics: {
        // how long the user has to make their pick (in seconds)
        TURN_LENGTH: 180,
    },
});
