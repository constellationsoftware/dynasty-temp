Ext.define('DynastyDraft.store.PickOrder', {
    extend: 'Ext.data.Store',

    model: 'DynastyDraft.model.PickOrder',
    sorters: { property: 'pick_order', direction: 'ASC' },
    
    proxy: 'memory'
});
