
class Equity.Main

    constructor: ->
        @root = new File($.fileName).parent.parent.parent
        @path = @root.absoluteURI

    init: =>
        @errors     = new Equity.Errors()
        @folders    = new Equity.Folders()
        @properties = new Equity.Properties()
        return unless @properties.list.length > 0
        @properties.export @_onExported

    _onExported: =>
        @errors.log()
        @errors.alert()
        bridge.quit()
