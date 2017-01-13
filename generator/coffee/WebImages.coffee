class Equity.WebImages

    constructor: (@property) ->
        @_initLayers()
        @_exportForeground()
        @_exportBackground()

    _initLayers: =>
        @_hideLayer "Foreground"
        @_hideLayer "Hotspots"
        @_hideLayer "Background"

    _exportForeground: =>
        @_showLayer "Foreground"
        path = "#{main.path}/exports/images/web/#{@property.id}-foreground.png"
        opts = new ExportOptionsPNG24()
        opts.antiAliasing = true;
        opts.transparency = true;
        opts.artBoardClipping = true
        file = new File path
        @property.doc.exportFile file, ExportType.PNG24, opts

    _exportBackground: =>
        @_hideLayer "Foreground"
        @_showLayer "Hotspots"
        @_showLayer "Background"
        path = "#{main.path}/exports/images/web/#{@property.id}-background.jpg"
        opts = new ExportOptionsPNG24()
        opts.antiAliasing = true;
        opts.transparency = false;
        opts.artBoardClipping = true
        file = new File path
        @property.doc.exportFile file, ExportType.PNG24, opts

    _showLayer: (name) =>
        for i in [0...@property.doc.layers.length]
            layer = @property.doc.layers[i]
            layer.locked = false
            layer.visible = true if layer.name is name

    _hideLayer: (name) =>
        for i in [0...@property.doc.layers.length]
            layer = @property.doc.layers[i]
            layer.locked = false
            layer.visible = false if layer.name is name
