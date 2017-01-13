class Equity.PdfImages

    constructor: (@property) ->
        @path = "#{main.path}/exports/images/pdf/#{@property.id}.png"
        @opts = new ExportOptionsPNG24()
        @opts.antiAliasing = true;
        @opts.transparency = false;
        @opts.artBoardClipping = true
        @_setupLayers()
        @_setupUnits()
        @_export()

    _setupLayers: =>
        for i in [0...@property.doc.layers.length]
            layer = @property.doc.layers[i]
            layer.locked = false
            switch layer.name
                when "Hotspots"
                    layer.visible = true
                when "Foreground"
                    layer.visible = true
                when "Background"
                    layer.visible = true
                else
                    layer.visible = false

    _setupUnits: =>
        for unit in @property.xmlData.units
            hotspot = @_getHotSpot unit.id
            if hotspot
                rgb   = hex2rgb("\#" + unit.color)
                color = new RGBColor()
                color.red   = rgb.r
                color.green = rgb.g
                color.blue  = rgb.b
                hotspot.fillColor = color

    _getHotSpot: (id) =>
        for item in @property.doc.pathItems
            if item.name.toLowerCase() is id.toLowerCase()
                if item.parent.name is "Hotspots"
                    return item
        error = "Could not find unit #{id} in property #{@property.id}"
        main.errors.push error
        return null

    _export: =>
        file = new File @path
        @property.doc.exportFile file, ExportType.PNG24, @opts
