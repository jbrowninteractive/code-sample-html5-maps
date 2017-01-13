import net.equityone.maps.event.Event

class InfoView

    data : null
    id   : null

    constructor: (@units) ->
        @node        = document.createElement "div"
        @mainNode    = document.createElement "div"
        @titleNode   = document.createElement "div"
        @contentNode = document.createElement "div"
        @pointerNode = document.createElement "div"
        @node.id     = "property-unit-info"
        @mainNode.className       = "main"
        @titleNode.className      = "title"
        @contentNode.className    = "content"
        @pointerNode.className    = "pointer"
        @units.addEventListener Event.SHOW_UNIT, @_show
        @units.addEventListener Event.HIDE_UNIT, @_hide
        document.body.appendChild @node
        document.body.appendChild @pointerNode
        @node.appendChild @pointerNode
        @node.appendChild @mainNode
        @mainNode.appendChild @titleNode
        @mainNode.appendChild @contentNode

    _show: (event) =>
        @node.style.display = "block"
        id = event.data.id
        x  = event.data.x
        y  = event.data.y
        @_populate id if @id isnt id
        @_position x, y
        @id = id

    _populate: (id) =>
        data = @_getUnitData id
        @titleNode.innerHTML = data.occupant
        @contentNode.style.backgroundColor = data.color
        @contentNode.innerHTML = ""
        for field in data.fields
            node = document.createElement "div"
            node.innerHTML =  "#{field.label}: #{field.value}"
            node.className = "field"
            @contentNode.appendChild node

    _position: (mouseX, mouseY) =>
        x    = mouseX - @node.offsetWidth  * 0.5
        y    = mouseY - @node.offsetHeight - @pointerNode.offsetHeight - 3
        pc   = "pointer"
        pl   = @node.offsetWidth * 0.5 - @pointerNode.offsetWidth * 0.5
        pt   = @node.offsetHeight
        minY = 0
        minX = 0
        maxX = document.body.offsetWidth

        if y < minY
            y = minY + @node.offsetHeight * 0.5
            if x < document.body.offsetWidth * 0.5
                x  = mouseX + 25
                pl = -@pointerNode.offsetHeight
                pc = "pointer left"
            else
                x  = mouseX - @node.offsetWidth - 25
                pl = @node.offsetWidth - 4
                pc = "pointer right"
            pt = mouseY - @node.offsetTop - @pointerNode.offsetHeight * 0.5
            pt = 2 if pt < 2

        if x < minX
            x  = minX
            pl = mouseX - @node.offsetLeft - @pointerNode.offsetWidth * 0.5
            pl = 2 if pl < 2

        if x > maxX
            x  = maxX
            pl = mouseX - @node.offsetLeft - @pointerNode.offsetWidth * 0.5

        @pointerNode.className  = pc
        @pointerNode.style.left = "#{pl}px"
        @pointerNode.style.top  = "#{pt}px"
        @node.style.left        = "#{x}px"
        @node.style.top         = "#{y}px"

    _getUnitData: (id) =>
        for unit in @data.units
            return unit if unit.id is id

    _hide: =>
        @node.style.display = "none"
