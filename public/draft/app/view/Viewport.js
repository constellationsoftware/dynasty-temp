Ext.define('DynastyDraft.view.Viewport', {
    extend: 'Ext.container.Viewport',

    requires: [
        'DynastyDraft.view.PlayerGrid',
        'DynastyDraft.view.PlayerQueue',
        'DynastyDraft.view.ShoutBoxContainer',
        'DynastyDraft.view.AdminControls',
        'DynastyDraft.view.Picks',
    ],

    layout: 'border',
    items: [
        /**
         * HEADER PANEL
         */
        {
            xtype: 'container',
            id: 'header_container',
            region: 'north',
            layout: {
                align: 'stretch',
                type: 'hbox',
            },
            height: 120,

            items: [{
                xtype: 'timer',
                width: 200,
            }, {
                xtype: 'panel',
                border: false,
                minWidth: 380,
                flex: 1,
                id: 'picks-scroller-container',
                items: [{
                    xtype: 'picks',
                    width: 2500,
                }, {
                    xtype: 'container',
                    cls: 'gradient-mask',
                    height: '100%'
                }]
            }, {
                xtype: 'container',
                width: 30,
            }, {
                xtype: 'shoutboxcontainer',
                width: 350,
            }],
        },
        

        /**
         * MAIN TABBED CONTAINER
         */
        {
            xtype: 'tabpanel',
            region: 'center',
            activeTab: 0,
            flex: 1,

            items: [{
                xtype: 'playergrid',
                title: 'Players'
            }, {
                xtype: 'rostergrid',
                title: 'Roster',
            }, {
                xtype: 'admincontrols',
                title: 'Draft Tools',
            }],
        },


        /**
         * "TOOLBOX" CONTAINER
         */
        {
            xtype: 'container',
            region: 'east',
            width: 250,
            flex: 1,
            layout: {
                align: 'stretch',
                type: 'fit'
            },
            split: true,
            
            defaults: {
                autoScroll: true,
            },
            items: [{
                xtype: 'playerqueue',
            }],
        }
    ],
});