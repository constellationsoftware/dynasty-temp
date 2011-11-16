Ext.define('DynastyDraft.store.Roster', {
    extend: 'DynastyDraft.store.Salaries',
    model: 'DynastyDraft.model.Salary',
    groupField: 'position',


    proxy: {
        type: 'rest',
        format: 'json',
        url: 'roster',
        root: 'results'
        
    },
});
