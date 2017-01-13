class BackgroundView

    constructor: (@parent) ->
        @node = document.createElement "div"
        @node.className = "layer background"
        @parent.appendChild @node

    render: (@data) =>
        @node.style.backgroundImage = "url(#{@data})"
