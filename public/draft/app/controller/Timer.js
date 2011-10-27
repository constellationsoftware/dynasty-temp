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

        this.taskRunner = new Ext.util.TaskRunner();
    },

    onTimeout: function() {
        // stop the timer
        this.taskRunner.stop(this.countdown);

        // notify listeners that the timer ran out
        this.application.fireEvent("timerfinish");

        this.taskRunner.start(this.countdown);
    },

    start: function() {
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
    },

    onViewRender: function(view) { this.view = view; this.view.updateTimer(); this.start() },

    statics: {
        // how long the user has to make their pick (in seconds)
        TURN_LENGTH: 120,
    },
});
