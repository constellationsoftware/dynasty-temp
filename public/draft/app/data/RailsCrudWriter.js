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
        var data = this.callParent(arguments),
        	isPhantom = record.phantom === true;

        if (!isPhantom && data.hasOwnProperty(record.idProperty)) {
            delete data[record.idProperty];
        }
        return data;
    }
});
