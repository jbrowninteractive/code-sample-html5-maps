import net.equityone.maps.view.LoaderView
import net.equityone.maps.view.BackgroundView
import net.equityone.maps.view.MidgroundView
import net.equityone.maps.view.ForegroundView
import net.equityone.maps.view.UnitsView
import net.equityone.maps.view.InfoView

class PropertyView

    constructor: ->
        @parent     = document.getElementById "pnlSiteMapFlash"
        @node       = document.createElement "div"
        @loader     = new LoaderView     @node
        @background = new BackgroundView @node
        @midground  = new MidgroundView  @node
        @foreground = new ForegroundView @node
        @units      = new UnitsView      @node
        @info       = new InfoView       @units
        @node.id            = "map-container"
        @node.style.cssText = @_css()
        @parent.appendChild @node

    render: (@data) =>
        @info.data = @data
        @loader.hide()
        @background.render @data.urls.background
        @midground.render  @data
        @foreground.render @data.urls.foreground
        @units.render      @data

    _css: =>
        width  = @parent.offsetWidth
        height = Math.ceil( width * 0.66 )
        "
        position: absolute;
        width: #{width}px;
        height: #{height}px;
        "
