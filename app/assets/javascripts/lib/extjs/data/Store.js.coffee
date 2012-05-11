window.Ext.define 'Ext.override.data.Store',
    override: 'Ext.data.Store'

    ###
    # @cfg {Boolean/String} remoteSortUseMapping
    # If set to "true", uses the field mapping property (if set) for the sorter, rather than the field name.
    # If set to "full", will append the model name to the mapping. This option does nothing unless
    # the {@link #remoteSort} option is set to true.
    ###
    remoteSortUseMapping: false

    ###
    # This override adds the ability to use the field mapping defined on the model instead
    # of the property name by setting the 'remoteSortUseMapping' property on the store. Note
    # that the field mapping is only used if it exists for that field, otherwise the name is
    # used
    ###
    decodeSorters: ->
        sorters = @callOverridden arguments
        fields = (if @model then @model::fields else null)
        if fields and @remoteSort and @remoteSortUseMapping
            for sorter in sorters
                field = fields.get(sorter.property)
                if field and field.mapping
                    if @remoteSortUseMapping is "full"
                        # Strips the namespace from the model class
                        # TODO: move the "underscore" method into an Ext.Inflector mixinfullModelClass = @model::modelName
                        idx = fullModelClass.lastIndexOf(".")
                        modelClass = fullModelClass.slice()
                        sorter.property = modelClass.underscore() + "." + field.mapping
                    else
                        sorter.property = field.mapping
        sorters
