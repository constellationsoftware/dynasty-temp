Ext.define('DynastyDraft.data.RailsCrudWriter', {
	extend: 'Ext.data.writer.Json',
	alias: 'writer.rails_crud',

    writeAllFields: false,

    /**
     * Removes the ID property from the data set.
     *
     * We never want the ID property to be sent with the data on a
     * CRUD update in Rails, since it will invoke the ID setter on
     * a record that already has an ID, and we'll get a warning.
     */
    getRecordData: function(record) {
        var data = this.callParent(arguments);

        // remove id property if present
        if (data.hasOwnProperty(record.idProperty)) {
            delete data[record.idProperty];
        }

        // reformat data hash so properties are wrapped in model names
        modelName = record.$className.split('.').pop().underscore();
        ret = {};
        ret[modelName] = data;
        return ret;
    }
});
