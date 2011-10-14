Ext.define('DynastyDraft.store.Players', {
    extend: 'Ext.data.Store',
    requires: 'DynastyDraft.model.Player',
    model: 'DynastyDraft.model.Player',
    autoLoad: true,
    
    groupField: 'position',
    sorters: ['name'],
});
