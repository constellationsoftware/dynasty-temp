Ext.define('DynastyDraft.controller.AdminControls', {
    extend: 'Ext.app.Controller',

    views: [ 'AdminControls' ],
    refs: [{
        ref: 'startButton',
        selector: 'viewport admincontrols button#start'
    }, {
        ref: 'pauseButton',
        selector: 'viewport admincontrols button#pause'
    }, {
        ref: 'resetButton',
        selector: 'viewport admincontrols button#reset'
    }],

    init: function() {
    	this.addEvents('click');

        this.control({
            'viewport admincontrols button#start': {
                click: this.onButtonClicked
            },
            'viewport admincontrols button#pause': {
                click: this.onPauseClicked
            },
            'viewport admincontrols button#reset': {
                click: this.onButtonClicked
            }
        });

        // enable/disable pick button on app status
        this.application.addListener(this.application.STATUS_STARTED, function() {
        }, this);

        // enable/disable pause button on app status
        this.application.addListener(this.application.STATUS_PICKING, function() {
            this.getPauseButton().setDisabled(false);
        }, this);
        this.application.addListener(this.application.STATUS_WAITING, function() {
            this.getPauseButton().setDisabled(true);
        }, this);
    },

    onButtonClicked: function(button) {
        switch (button.getItemId()) {
        case 'start':
            $.post('/draft/start');
            break;
        case 'pause':
            if (button.getText() === 'Stop Countdown') {
                this.application.fireEvent(this.application.STATUS_PAUSED);
            } else {
                this.application.fireEvent(this.application.STATUS_RESUMED);
            }
            break;
        case 'reset':
            $.post('/draft/reset');
            break;
        }
    },

    onPauseClicked: function(button) {
		// toggles
        switch (button.getText()) {
        case 'Stop Countdown': button.setText('Reset Countdown'); break;
        case 'Reset Countdown': button.setText('Stop Countdown'); break;
        }
        this.onButtonClicked(button);
    }
});
