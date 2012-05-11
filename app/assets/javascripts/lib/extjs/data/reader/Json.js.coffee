window.Ext.define 'Ext.override.data.reader.Json',
    override: 'Ext.data.reader.Json'

    extractValueFromMapArray: (obj, arr) ->
        prop = arr.shift()
        val = if obj.hasOwnProperty prop then obj[prop] else null
        if val is null or arr.length is 0 then return val
        arguments.callee val, arr

    createAccessor: do ->
        return (expr) ->
            return Ext.emptyFn if Ext.isEmpty expr
            return expr if Ext.isFunction expr
            if @useSimpleAccessors? and expr.indexOf('.') > 0
                fn = (obj, map) -> @extractValueFromMapArray obj, map.split '.'
                return Ext.Function.bind fn, @, expr, true
            (obj) -> return obj[expr]
