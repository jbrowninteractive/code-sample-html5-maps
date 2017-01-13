class LoaderView

    constructor: (@parent) ->
        @node = document.createElement "div"
        @node.className = "layer loader"
        @parent.appendChild @node

    hide: =>
        @parent.removeChild @node
