
class Equity.SvgData

    constructor: (@property) ->
        @path = "#{main.path}/exports/data/svg/#{@property.id}.svg"
        @opts = new ExportOptionsSVG()
        @opts.preserveEditability = false
        @opts.embedRasterImages = true
        @opts.embedAllFonts = false
        @_setupLayers()
        @_setupUnits()
        @_export()

    _setupLayers: =>
        for i in [@property.doc.layers.length-1...-1]
            layer = @property.doc.layers[i]
            if layer.name isnt "Hotspots"
                layer.visible = true
                layer.locked  = false
                layer.remove()

    _setupUnits: =>
        for item in @property.doc.pathItems
            if item.parent.name is "Hotspots"
                item.name = "uid#{_i}|#{item.name}"


    _export: =>
        file = new File @path
        @property.doc.exportFile file, ExportType.SVG, @opts
