Ext.define('DynastyDraft.view.Viewport', {
    extend: 'Ext.container.Viewport',

    requires: [
        'DynastyDraft.view.PlayerGrid',
        'DynastyDraft.view.PlayerQueue',
        'DynastyDraft.view.ShoutBoxContainer',
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
                margin: '10, 5',
            }, {
                xtype: 'container',
                flex: 1,
            }, {
                xtype: 'shoutboxcontainer',
                width: 400,
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

            items: [
                {
                    xtype: 'playergrid',
                    title: 'Players'
                },
                {
                    xtype: 'rostergrid',
                    title: 'Roster',
                },
                {
                    xtype: 'panel',
                    title: 'Recommendation',
                },
                {
                    xtype: 'panel',
                    title: 'Rules',
                },
            ],
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
            items: [
                {
                    xtype: 'playerqueue',
                },
            ],
        },
    ],
});