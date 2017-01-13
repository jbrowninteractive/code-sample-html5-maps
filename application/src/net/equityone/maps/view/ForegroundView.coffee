class ForegroundView

    constructor: (@parent) ->
        @node = document.createElement "div"
        @node.className = "layer foreground"
        @parent.appendChild @node

    render: (@data) =>
        @node.style.backgroundImage = "url(#{@data})"
