
class Equity.Properties

    constructor: ->
        @index = -1
        @list  = new Equity.PropertyList()

    export: (@callback) =>
        @_next()

    _next: =>
        if ++@index is @list.length
            @callback()
            return
        property = @list[@index]
        property.export @_next
