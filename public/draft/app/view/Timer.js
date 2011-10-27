Ext.define('DynastyDraft.view.Timer', {
    extend: 'Ext.panel.Panel',
    /*mixins: {
        observable: 'Ext.util.Observable'
    },*/

    alias: 'widget.timer',
    border: 0,
    styleHtmlContent: true,
    styleHtmlCls: 'timer-display',

    updateTimer: function(minutes, seconds) {
        if (minutes === 0 && seconds === 0) {
            minutes = seconds = '--';
        }

        var data = {
            minutes: minutes,
            seconds: seconds
        };
        var tpl = Ext.create('Ext.XTemplate', this.getCountdownTpl(), this.getTplConfig());
        tpl.overwrite(this.body, data);
    },

    getTimeSeparator: function() { return ':'; },
    formatMinutes: function(minutes) {
        if (isNaN(minutes)) { return minutes; }
        else { return minutes > 0 ? minutes : '0'; }
    },
    formatSeconds: function(seconds) {
        if (isNaN(seconds)) { return seconds; }
        else { return Ext.util.Format.leftPad(seconds, 2, '0'); }
    },

    getCountdownTpl: function() {
        return [
            '<span class="minutes">{[this.formatMinutes(values.minutes)]}</span>'+this.getTimeSeparator(),
            '<span class="seconds">{[this.formatSeconds(values.seconds)]}</span>',
        ].join('');
    },

    getTplConfig: function() {
        return {
            disableFormats: true,
            formatMinutes: this.formatMinutes,
            formatSeconds: this.formatSeconds,
        };
    },
});
