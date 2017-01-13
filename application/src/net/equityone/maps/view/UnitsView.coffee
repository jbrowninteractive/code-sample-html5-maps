import net.equityone.maps.event.EventDispatcher
import net.equityone.maps.event.Event
import net.equityone.maps.common.Utils

class UnitsView extends EventDispatcher

    scaleX : 1
    scaleY : 1

    constructor: (@parent) ->
        super()
        @node           = document.createElement "canvas"
        @node.className = "layer units"
        @ctx            = @node.getContext "2d"
        @parent.appendChild @node

    render: (@data) =>
        @node.onmousemove = @_onMouse
        @node.onmousedown = @_onMouse
        @node.onmouseout  = @_onMouseOut
        @scaleX           = @parent.offsetWidth  / @data.width
        @scaleY           = @parent.offsetHeight / @data.height
        @node.width       = @data.width
        @node.height      = @data.height
        document.body.onmousedown = @_onBodyDown
        for unit in @data.units
            unit.uid = _i+1
            action   = if unit.shape is "rect" then @_drawRect else @_drawPoly
            action unit

    _onMouse: (event) =>
        pos  = Utils.getPosition @node
        x    = parseInt( (event.pageX - pos.x) / @scaleX)
        y    = parseInt( (event.pageY - pos.y) / @scaleY)
        data = @ctx.getImageData(x, y, 1, 1).data
        uid  = data[0]
        unit = @_getUnit uid
        if unit
            data = id:unit.id, x:event.pageX, y:event.pageY
            @dispatchEvent Event.SHOW_UNIT, data
        else
            @dispatchEvent Event.HIDE_UNIT

    _onMouseOut: =>
            @dispatchEvent Event.HIDE_UNIT

    _getUnit: (uid) =>
        for unit in @data.units
            return unit if unit.uid is uid

    _drawRect: (unit) =>
        return unless unit.coords
        coords         = unit.coords.split ","
        x              = coords[0]
        y              = coords[1]
        width          = coords[2] - x
        height         = coords[3] - y
        @ctx.fillStyle = "rgb(#{unit.uid}, 0, 0)"
        @ctx.fillRect x, y, width, height

    _drawPoly: (unit) =>
        return unless unit.coords
        points         = @_parseCoords unit.coords
        @ctx.fillStyle = "rgb(#{unit.uid}, 0, 0)"
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

    _onBodyDown: (event) =>
        target = event.target or event.srcElement;
        @dispatchEvent Event.HIDE_UNIT if target isnt @node

