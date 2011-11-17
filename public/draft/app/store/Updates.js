Ext.define('DynastyDraft.store.Updates', {
    extend: 'Ext.data.Store',

    model: 'DynastyDraft.model.Update',

    autoLoad: true,

    /*
    constructor: function(config) {
        this.callParent([config]);

        // append empty group "stubs" taken from validation definition
        this.add(this.addEmptyValidGroups());
    },

    addEmptyValidGroups: function() {
        var klass = this.getProxy().getModel();
        var model = new klass();
        var validators = model.validations;
        var groupField = this.groupField;
        var dataGroups = [];
        Ext.Array.forEach(this.getGroups(), function(item) { dataGroups.push(item.name); });

        // find the validator associated with our group field
        var unusedGroups = [];
        Ext.Array.forEach(validators, function(item) {
            // if we find an inclusive validator for our group field
            if (item.type === 'inclusion' && item.field === groupField) {
                // filter out the groups that already appear in the data
                unusedGroups = Ext.Array.filter(item.list, function(item) {
                    return dataGroups.indexOf(item) === -1;
                });
            }
        });

        var data = [];
        for (var i = 0, l = unusedGroups.length; i < l; ++i) {
            var item = new klass();
            item.set(groupField, unusedGroups[i]);
            item.set('empty', true);
            data.push(item);
        }

        return data;
    },
    */

    proxy: {
        type: 'rest',
        url: 'status.json',
        reader: {
            type: 'json',
            root: 'results'
        }
    },
});
