window.Ext.define 'Ext.override.data.proxy.Server',
    override: 'Ext.data.proxy.Server'
    limitParam: 'per'
    constructor: -> @callOverridden arguments
