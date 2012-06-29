Ext.define('DynastyDraft.view.Viewport', {
    extend: 'Ext.container.Viewport',
    id: 'viewport',

    requires: [
        'DynastyDraft.view.PlayerGrid',
        'DynastyDraft.view.AdminControls',
        'DynastyDraft.view.Picks',
        'DynastyDraft.view.RecommendedPicks',
        'DynastyDraft.view.DraftBoard'
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
                type: 'hbox'
            },
            height: 120,

            items: [{
                xtype: 'panel',
                border: false,
                id: 'countdown-wrap',
                cls: 'well dark-well',
                width: 250
            }, {
                xtype: 'panel',
                border: false,
                minWidth: 380,
                flex: 1,
                id: 'picks-scroller-container',
                items: [{
                    xtype: 'picks',
                    width: 2500
                }]
            }]
        },
        

        /**
         * MAIN TABBED CONTAINER
         */
        {
            layout: 'border',
            region: 'center',
            border: false,
            bodyBorder: false,
            frame: false,
            items: [{
                xtype: 'tabpanel',
                region: 'center',
                id: 'navigation',
                activeTab: 0,
                listeners: {
                    afterRender: function() {
                        // insert a tab spacer
                        this.getTabBar().insert(0, { xtype: 'tbfill' });
                    }
                },
                border: false,
                bodyBorder: false,
                frame: false,
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
                            data: [
                                { id: 'all', name: 'Show All' },
                                { id: 'QB', name: 'Quarterbacks' },
                                { id: 'WR', name: 'Wide Receivers' },
                                { id: 'RB', name: 'Running Backs' },
                                { id: 'TE', name: 'Tight Ends' },
                                { id: 'K', name: 'Kickers' },
                                { id: 'DL', name: 'Defensive Linemen' },
                                { id: 'LB', name: 'Linebacker' },
                                { id: 'DB', name: 'Defensive Back' }
                            ]
                        }),
                        value: 'all'
                    }, {
                        xtype: 'tbfill'
                    }, {
                        xtype: 'button',
                        text: 'Draft Player',
                        itemId: 'submit',
                        scale: 'large',
                        width: 100,
                        disabled: true
                    }]
                }, {
                    xtype: 'playergrid',
                    title: 'Full Player List'
                }, {
                    xtype: 'roster',
                    title: 'My Roster'
                }, {
                    xtype: 'draftboard',
                    title: 'League Draft Board'
                }, /*{
                    xtype: 'autopickorder',
                    title: 'View Full Player List'
                },*/ {
                    xtype: 'admincontrols',
                    title: 'Admin Draft Tools'
                }]
            }, {
                xtype: 'shoutboxcontainer',
                id: 'shoutbox-container',
                region: 'south',
                split: true,
                height: '20%',
                collapsible: true,
                collapseMode: 'header',
                hideCollapseTool: true
            }]
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
                )
            }]
        }
    ],
});
