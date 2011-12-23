Ext.define('DynastyDraft.view.NewPlayerDialog', {
    extend: 'Ext.window.Window',

    alias: 'widget.newplayerdialog',
    title: 'Choose a new player',
    closable: true,
    closeAction: 'hide',
    hideMode: 'offsets',
    draggable: false,
    resizable: false,
    constrain: true,
    minWidth: 300,
    minHeight: 200,
    maxWidth: 600,
    maxHeight: 500,
    modal: true,
    layout: 'fit',

    constructor: function() {
        this.callParent(arguments);
        this.addEvents('submit');
    },

    items: [{
        xtype: 'form',
        itemId: 'autosuggest-form',
        border: false,
        bodyPadding: 5,
        fieldDefaults: {
            labelWidth: 55,
            labelAlign: 'left'
        },

        items: [{
            xtype: 'combo',
            name: 'full_name',
            emptyText: 'Start typing a player\'s name',
            queryMode: 'remote',
            queryParam: 'by_name',
            valueField: 'id',
            displayField: 'full_name',
            store: Ext.create('DynastyDraft.store.PlayerSearch'),
            minChars: 3,
            width: 300,
            selectOnFocus: true,
            matchFieldWidth: false,
            listConfig: {
                autoScroll: true,
                minHeight: 14,
                maxHeight: 250,
                width: 350,
                height: null,
                loadingText: 'Searching...',
                emptyText: 'No matching players found.',
                cls: 'playersearch-boundlist',
                shadow: 'drop',
                padding: 0,
                itemTpl: Ext.create('Ext.XTemplate',
                    '<tpl for=".">',
                        '<ul class="{[xindex % 2 === 0 ? "even" : "odd"]}">',
                            '<li class="name">{full_name}</li>',
                            '<li class="position">{position}</li>',
                            '<li class="salary">{contract_amount:usMoney}</li>',
                        '</ul>',
                    '</tpl>'
                )
            },
            listeners: {
                // set the cached record of the form to the new selected record
                select: function(view, records) {
                    if (records.length > 0) {
                        var form = view.up('form').getForm();
                        form._record = records[0];
                    }
                }
            },
            validator: function(value) { return !!value; }
        }],

        buttons: [{
            text: 'Submit',
            itemId: 'submit',
            handler: function() {
                var form = this.up('form').getForm(),
                    window = this.up('window');
                if (form.isValid() && form.getRecord() !== form._lastRecord) {
                    window.fireEvent('submit', form.getRecord(), form._lastRecord);
                }
                window.close();
            }
        },{
            text: 'Cancel',
            handler: function() {
                this.up('form').getForm()._lastRecord = null;
                this.up('window').close();
            }
        }]
    }],

    listeners: {
        beforeclose: function() {
            var form = this.getComponent('autosuggest-form');
            if (form) { form.getForm().reset(); }
        }
    },

    /**
     * Small modification to load the passed record before showing
     */
    show: function(record) {
        record = record || null;
        if (record !== null) {
            var form = this.getComponent('autosuggest-form').getForm();
            if (form) {
                form.loadRecord(record);
                form._lastRecord = record;
            }
        }
        this.callParent();
    }
});
