Ext.define('DynastyDraft.store.Roster', {
    extend: 'DynastyDraft.store.Salaries',
    
    groupField: 'position',

    data: {
        picks: []
    },

    proxy: {
        type: 'memory',
        reader: {
            type: 'json',
            root: 'picks',
        }
    },
});
