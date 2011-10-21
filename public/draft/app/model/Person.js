Ext.define('DynastyDraft.model.Person', {
    extend: 'Ext.data.Model',

    fields: [
        { name: 'first_name' },
        { name: 'last_name' },
        {
            name: 'name',
            convert: function(value, record) {
                var firstName = record.get('first_name') || null;
                return (firstName !== null) ?
                    firstName + ' ' + record.get('last_name') :
                    record.get('last_name');
            },

            sortType: function(fullName) {
                var pattern = /(\w+)(?: (.*))?/;
                var matches = pattern.exec(fullName);
                return matches !== null ? (matches.length > 2 ?
                    matches[2].toUpperCase()+matches[1].toLowerCase() :
                    matches[2].toUpperCase()) : '';
            },
        },
    ],
});
