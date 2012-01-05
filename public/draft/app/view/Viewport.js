Ext.define('DynastyDraft.view.Viewport', {
    extend: 'Ext.container.Viewport',

    requires: [
        'DynastyDraft.view.PlayerGrid',
        'DynastyDraft.view.AdminControls',
        'DynastyDraft.view.Picks',
        'DynastyDraft.view.RecommendedPicks',
        //'DynastyDraft.view.PlayerQueue',
        //'DynastyDraft.view.ShoutBoxContainer',
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
            },
            /*
            {
                xtype: 'container',
                width: 30,
            },
            {
                xtype: 'shoutboxcontainer',
                width: 350,
            }
            */
            ],
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
                xtype: 'panel',
                title: 'Recommended',
                id: 'recommendedpickwrap',
                autoScroll: true,
                items: [{
                    xtype: 'recommendedpicks',
                    padding: 10
                }],
                tbar: [{
                    xtype: 'combo',
                    itemId: 'filter',
                    valueField: 'id',
                    displayField: 'name',
                    queryMode: 'local',
                    fieldLabel: 'Filter',
                    labelAlign: 'left',
                    labelWidth: 40,
                    editable: false,
                    store: Ext.create('Ext.data.Store', {
                        // store configs
                        autoDestroy: true,
                        // reader configs
                        idIndex: 0,
                        fields: ['id', 'name'],
                        data: [{
                            id: 'all',
                            name: 'Show All',
                        }, {
                            id: 'QB',
                            name: 'Quarterbacks'
                        }, {
                            id: 'WR',
                            name: 'Wide Receivers'
                        }, {
                            id: 'RB',
                            name: 'Running Backs'
                        }, {
                            id: 'TE',
                            name: 'Tight Ends'
                        }, {
                            id: 'T',
                            name: 'Offensive Tackle'
                        }, {
                            id: 'G',
                            name: 'Guards'
                        }, {
                            id: 'C',
                            name: 'Centers'
                        }, {
                            id: 'K',
                            name: 'Kickers'
                        }]
                    }),
                    value: 'all'
                }, {
                    xtype: 'tbfill'
                }, {
                    xtype: 'button',
                    text: 'Confirm Pick',
                    itemId: 'submit',
                    scale: 'large',
                    disabled: true
                }],

            }, {
                xtype: 'playergrid',
                title: 'All Players',
            }, {
                xtype: 'roster',
                title: 'Roster',
            }, {
                xtype: 'admincontrols',
                title: 'Draft Tools',
            }],
        }, {
            xtype: 'toolbar',
            region: 'south',
            height: 35,
            id: 'statusbar',

            items: [{
                xtype: 'tbfill'
            }, {
                xtype: 'tbtext',
                data: USER_BALANCE,
                id: 'user-balance',
                tpl: Ext.create('Ext.XTemplate',
                    '<tpl for=".">',
                        '<dl>',
                            '<dt>Balance:</dt>',
                            '<dd class="balance amount {[values < 0 ? "deficit" : ""]}">',
                                '{values:usMoney}',
                            '</dd>',
                            '<dt>Total Salary Obligation:</dt>',
                            '<dd class="obligation amount {[values < 0 ? "deficit" : ""]}">',
                                '{values:usMoney}',
                            '</dd>',
                       '</dl>',
                    '</tpl>'
                ),
            }]
        }

        /**
         * "TOOLBOX" CONTAINER
         */
        /*
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
        */
    ],
});