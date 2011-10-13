/*

This file is part of Ext JS 4

Copyright (c) 2011 Sencha Inc

Contact:  http://www.sencha.com/contact

Commercial Usage
Licensees holding valid commercial licenses may use this file in accordance with the Commercial Software License Agreement provided with the Software or, alternatively, in accordance with the terms contained in a written agreement between you and Sencha.

If you are unsure which license is appropriate for your use, please contact the sales department at http://www.sencha.com/contact.

*/
Ext.Loader.setConfig({enabled: true});

Ext.Loader.setPath('Ext.ux', '../ux/');

Ext.require([
    'Ext.tab.*',
    'Ext.ux.TabCloseMenu'
]);

Ext.onReady(function() {
    var currentItem;
    var tabs = Ext.createWidget('tabpanel', {
        renderTo: 'tabs',
        resizeTabs: true,
        enableTabScroll: true,
        width: 600,
        height: 250,
        defaults: {
            autoScroll:true,
            bodyPadding: 10
        },
        items: [{
            title: 'Tab 1',
            iconCls: 'tabs',
            html: 'Tab Body<br/><br/>' + Ext.example.bogusMarkup,
            closable: true
        }],
        plugins: Ext.create('Ext.ux.TabCloseMenu', {
            extraItemsTail: [
                '-',
                {
                    text: 'Closable',
                    checked: true,
                    hideOnClick: true,
                    handler: function (item) {
                        currentItem.tab.setClosable(item.checked);
                    }
                }
            ],
            listeners: {
                aftermenu: function () {
                    currentItem = null;
                },
                beforemenu: function (menu, item) {
                    var menuitem = menu.child('*[text="Closable"]');
                    currentItem = item;
                    menuitem.setChecked(item.closable);
                }
            }
        })
    });

    // tab generation code
    var index = 0;
    while(index < 3){
        addTab(index % 2);
    }

    function addTab (closable) {
        ++index;
        tabs.add({
            title: 'New Tab ' + index,
            iconCls: 'tabs',
            html: 'Tab Body ' + index + '<br/><br/>' + Ext.example.bogusMarkup,
            closable: !!closable
        }).show();
    }

    Ext.createWidget('button', {
        renderTo: 'addButtonCt',
        text: 'Add Closable Tab',
        handler: function () {
            addTab(true);
        },
        iconCls:'new-tab'
    });

    Ext.createWidget('button', {
        renderTo: 'addButtonCt',
        text: 'Add Unclosable Tab',
        handler: function () {
            addTab(false);
        },
        iconCls:'new-tab',
        style: 'margin-left: 8px;'
    });
});

