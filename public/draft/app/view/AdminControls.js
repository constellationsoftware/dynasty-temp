Ext.define('DynastyDraft.view.AdminControls', {
	extend: 'Ext.panel.Panel',
	alias: 'widget.admincontrols',

	layout: {
	    type: 'hbox',
	    align: 'fit',
	    flex: 1,
	},
	height: '100%',

	defaults: {
	    margin: 5,
	    padding: 5,
	    flex: 1,
	    scale: 'large',
	},

	items: [{
	    itemId: 'start',
	    xtype: 'button',
	    text: 'Start',
	}, {
	    itemId: 'pause',
	    xtype: 'button',
	    text: 'Stop Countdown',
	    disabled: true,
	    enableToggle: true,
	}, {
	    itemId: 'reset',
	    xtype: 'button',
	    text: 'Reset',
	}]
});
