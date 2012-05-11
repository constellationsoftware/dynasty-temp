Ext.define('DynastyDraft.store.Persons', {
    extend: 'Ext.data.Store',
    model: 'Person',
    autoLoad: true,
    
    sorters: { property: 'name', direction: 'ASC'},
});
