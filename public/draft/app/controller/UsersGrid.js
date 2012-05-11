Ext.define('DynastyDraft.controller.UsersGrid', {
    extend: 'Ext.app.Controller',

    stores: [ 'Users' ],
    models: [ 'User' ],
    views: [ 'UsersGrid' ],
});