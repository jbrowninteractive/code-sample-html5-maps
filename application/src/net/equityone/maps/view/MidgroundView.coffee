class MidgroundView

    constructor: (@parent) ->
        @node = document.createElement "canvas"
        @node.className = "layer midground"
        @ctx = @node.getContext "2d"
        @parent.appendChild @node

    render: (@data) =>
        @node.width  = @data.width
        @node.height = @data.height
        for unit in @data.units
            action = if unit.shape is "rect" then @_drawRect else @_drawPoly
            action unit

    _drawRect: (unit) =>
        return unless unit.coords?
        coords = unit.coords.split ","
        x      = coords[0]
        y      = coords[1]
        width  = coords[2] - x
        height = coords[3] - y
        @ctx.fillStyle = unit.color
        @ctx.fillRect x, y, width, height

    _drawPoly: (unit) =>
        return unless unit.coords?
        points = @_parseCoords unit.coords
        @ctx.fillStyle = unit.color
        @ctx.beginPath()
        @ctx.moveTo points[0].x, points[0].y
        for point in points
            @ctx.lineTo point.x, point.y
        @ctx.closePath()
        @ctx.fill()

    _parseCoords: (coords) =>
        points = []
        coords = coords.split ","
        for i in [0...coords.length] by 2
            x = coords[i]
            y = coords[i+1]
            points.push x:x, y:y
        return points
