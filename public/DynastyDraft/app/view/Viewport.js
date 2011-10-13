Ext.define('DynastyDraft.view.Viewport', {
    extend: 'Ext.container.Viewport',

    requires: [
        'DynastyDraft.view.PlayerGrid',
        'DynastyDraft.view.ShoutBoxContainer',
    ],

    padding: 10,

    layout: {
        type: 'border'
    },

    initComponent: function() {
        this.items = [
            /**
             * HEADER PANEL
             */
            {
                xtype: 'panel',
                region: 'north',
                layout: {
                    align: 'stretch',
                    type: 'hbox',
                },
                height: 120,

                items: [
                    {
                        xtype: 'image',
                        src: 'resources/images/dynasty_logo.png',
                    },
                    {
                        xtype: 'container',
                        flex: 1,
                    },
                    /*{
                        xtype: 'textareafield',
                        margin: 0,
                        width: 400,
                    },*/
                    {
                        xtype: 'shoutboxcontainer',
                        width: 400,
                    },
                ],
            },
            

            /**
             * MAIN TABBED CONTAINER
             */
            {
                xtype: 'tabpanel',
                region: 'center',
                activeTab: 0,

                items: [
                    {
                        xtype: 'playergrid',
                        store: 'Players'
                    },
                    {
                        xtype: 'panel',
                        title: 'Roster Review',
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
                maintainFlex: true,
                layout: {
                    align: 'stretch',
                    type: 'vbox'
                },
                closable: true,
                closeAction: 'hide',
                collapseDirection: 'right',
                collapsed: false,
                collapsible: true,
                frameHeader: false,
                headerPosition: 'left',
                title: 'DRAFT TOOLBOX',
                collapseMode: 'header',
                split: true,

                items: [
                    {
                        xtype: 'grid',
                        padding: '',
                        autoScroll: true,
                        overlapHeader: true,
                        title: 'Draft Queue',
                        store: 'PlayerQueue',
                        columnLines: true,
                        flex: 1,
                        viewConfig: {
                            plugins: [
                                {
                                    ptype: 'gridviewdragdrop',
                                    dragText: 'Drag to reorder your queue',
                                    ddGroup: 'PlayerGridDD',
                               },
                            ],
                        },
                        columns: [
                            {
                                xtype: 'gridcolumn',
                                width: 114,
                                layout: {
                                    type: 'fit'
                                },
                                dataIndex: 'name',
                                fixed: true,
                                groupable: true,
                                hideable: false,
                                text: 'Name'
                            },
                            {
                                xtype: 'gridcolumn',
                                id: 'DropSalary',
                                dataIndex: 'salary',
                                text: 'Salary'
                            },
                            {
                                xtype: 'numbercolumn',
                                itemId: 'Rush TD',
                                dataIndex: 'rush_td',
                                text: 'Rush TD'
                            },
                        ],
                        features: [
                            {
                                ftype: 'summary'
                            },
                        ],
                    },
                ],
            },


            /**
             * FOOTER CONTAINER
             */
            /*{
                xtype: 'tabpanel',
                region: 'south',
                height: 200,
                closable: true,
                closeAction: 'hide',
                collapseDirection: 'bottom',
                collapsed: false,
                collapsible: true,
                frameHeader: false,
                hideCollapseTool: true,
                overlapHeader: true,
                activeTab: 0,
                split: true,

                items: [
                    {
                        xtype: 'container',
                        activeItem: 0,
                        layout: {
                            type: 'absolute'
                        },
                        title: 'Chat',
                        items: [
                            {
                                xtype: 'textareafield',
                                border: 2,
                                height: 100,
                                margin: '',
                                padding: 10,
                                width: 500,
                                x: 0,
                                y: 0
                            },
                            {
                                xtype: 'button',
                                margin: 10,
                                width: 100,
                                text: 'Send',
                                x: 0,
                                y: 110
                            }
                        ]
                    },
                    {
                        xtype: 'panel',
                        activeItem: 0,
                        layout: {
                            type: 'card'
                        },
                        title: 'Recent Drafts'
                    },
                    {
                        xtype: 'panel',
                        activeItem: 0,
                        layout: {
                            type: 'card'
                        },
                        closable: true,
                        closeAction: 'hide',
                        collapseDirection: 'bottom',
                        collapsed: false,
                        collapsible: true,
                        title: 'Another Option'
                    },
                ],
            },*/
        ];

        this.callParent(arguments);
    }
});