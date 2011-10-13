Ext.define('DynastyDraft.view.ShoutBoxContainer', {
    extend: 'Ext.container.Container',
    requires: [ 'DynastyDraft.view.ShoutBox' ],

    alias: 'widget.shoutboxcontainer',
    layout: {
        align: 'stretch',
        type: 'vbox',
    },

    initComponent: function() {
        var _this = this;
        this.items = [
            {
                xtype: 'shoutbox',
                flex: 1,
            },
            {
                xtype: 'form',
                id: 'shoutbox_text_entry',
                border: 0,
                items: [
                    {
                        xtype: 'textfield',
                        emptyText: 'Type some profanity and hit ENTER',
                        margin: 0,
                        padding: 0,
                        enableKeyEvents: true,
                        //allowBlank: false,
                        anchor: '-2',
                  },
                ],

                /*
                buttons: [
                    {
                        text: 'Submit',
                        formBind: true, //only enabled once the form is valid
                        disabled: true,
                        handler: function() {
                            var form = this.up('form').getForm();
                            if (form.isValid()) {
                                console.log("hi");
                            }
                        }
                    },
                ],
                */
            },
        ];

        this.callParent();
    }
});
