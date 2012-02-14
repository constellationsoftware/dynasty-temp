Ext.define('DynastyDraft.view.Viewport', {
    extend: 'Ext.container.Viewport',
    id: 'viewport',

    requires: [
        'DynastyDraft.view.PlayerGrid',
        'DynastyDraft.view.AdminControls',
        'DynastyDraft.view.Picks',
        'DynastyDraft.view.RecommendedPicks',
        'DynastyDraft.view.DraftBoard'
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
                title: 'Recommended Picks',
                id: 'recommendedpickwrap',
                layout: 'fit',
                autoScroll: true,
                items: [{
                    xtype: 'recommendedpicks',
                    padding: 10,
                    loadMask: false, // we'll use the one on the parent
                    maskOnDisable: false
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
                            id: 'K',
                            name: 'Kickers'
                        }, {
                            id: 'DL',
                            name: 'Defensive Linemen'
                        }, {
                            id: 'LB',
                            name: 'Linebacker'
                        }, {
                            id: 'DB',
                            name: 'Defensive Back'
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
                    width: 100,
                    disabled: true
                }, {
                    xtype: 'button',
                    text: 'Set Autopick',
                    itemId: 'autopick',
                    scale: 'large',
                    width: 100
                }]
            }, /*{
                xtype: 'playergrid',
                title: 'All Players',
            },*/ {
                xtype: 'roster',
                title: 'My Roster',
            },
                {
                xtype: 'draftboard',
                title: 'League Draft Board',
            },
                {
                xtype: 'admincontrols',
                title: 'Admin Draft Tools',
            }],
        }, {
            xtype: 'toolbar',
            region: 'south',
            height: 30,
            id: 'statusbar',

            items: [{
                xtype: 'tbfill'
            }, {
                xtype: 'tbtext',
                id: 'user-balance',
                data: {
                    balance: USER_BALANCE,
                    salary_total: SALARY_TOTAL
                },
                tpl: Ext.create('Ext.XTemplate',
                    '<tpl for=".">',
                        '<ul>',
                            '<li class="label">Balance:</li>',
                            '<li id="team-balance" class="amount {[values.balance < 0 ? "deficit" : ""]}">',
                                '{balance:usMoney}',
                            '</li>',
                            '<li class="label">Total Salary Obligation:</li>',
                            '<li id="team-salary" class="amount {[values.salary_total > values.balance ? "deficit" : ""]}">',
                                '{salary_total:usMoney}',
                            '</li>',
                       '</ul>',
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
