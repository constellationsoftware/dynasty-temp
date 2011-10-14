Ext.define('DynastyDraft.store.Persons', {
    extend: 'Ext.data.Store',
    requires: 'DynastyDraft.model.Person',
    model: 'DynastyDraft.model.Person',
    autoLoad: true,
    
    sorters: { property: 'name', direction: 'ASC'},
});
