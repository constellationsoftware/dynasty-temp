Ext.define('DynastyDraft.view.Viewport', {
    extend: 'Ext.container.Viewport',

    requires: [
        'DynastyDraft.view.PlayerGrid',
        'DynastyDraft.view.ShoutBoxContainer',
    ],

    layout: {
        type: 'border'
    },

    initComponent: function() {
        this.items = [
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

                items: [
                    {
                        xtype: 'container',
                        id: 'header_spacer',
                        style: 'background: transparent;',
                        flex: 1,
                    },
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
        ];

        this.callParent(arguments);
    }
});