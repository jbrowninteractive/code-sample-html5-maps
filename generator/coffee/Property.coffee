class Equity.Property

    constructor: (@id, @path) ->
        @file = new File @path

    export: (@callback) =>
        unless @file.exists
            error = "Could not find design file for property #{property.id}"
            main.errors.push error
            @callback()
            return
        app.userInteractionLevel = UserInteractionLevel.DONTDISPLAYALERTS
        app.open @file
        @doc     = app.activeDocument
        @xmlData = new Equity.XmlData @
        @xmlData.export @_onXmlData

    _onXmlData: =>
        #check for valid data and error out if it doesn't exist
        @pdfImages = new Equity.PdfImages @
        @webImages = new Equity.WebImages @
        @svgData   = new Equity.SvgData   @
        @jsonData  = new Equity.JsonData  @
        @doc.close SaveOptions.DONOTSAVECHANGES
        @callback()
