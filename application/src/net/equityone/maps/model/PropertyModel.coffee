import net.equityone.maps.common.Utils
import net.equityone.maps.event.EventDispatcher
import net.equityone.maps.event.Event

class PropertyModel extends EventDispatcher

    home = if Utils.isSigma() then "sitemaps" else "site_maps"
    data :
        id     : null
        width  : 0
        height : 0
        units  :[]
        urls   :
            background : null
            foreground : null
    positionData : null
    propertyData : null
    loadCount    : 0

    constructor: ->
        super()
        @data.id              = Utils.getQuery "ID"
        @data.urls.background = "#{home}/assets/maps/#{@data.id}-background.png"
        @data.urls.foreground = "#{home}/assets/maps/#{@data.id}-foreground.png"

    fetch: =>
        @_getPositionData()
        @_getPropertyData()
        @_getSizeData()

    _getPositionData: =>
        url  = "#{home}/data/#{@data.id}.json"
        Utils.request url, (event) =>
            @positionData = JSON.parse event.data
            @_combine() if @propertyData
            @_handleLoad()

    _getPropertyData: =>
        url      = "#{location.protocol}//#{location.host}"
        internal = "/siteplanbrowser/xmlgen.aspx?ID=#{@data.id}"
        external = "/tools/xmlgen.aspx?ID=#{@data.id}"
        url     += if Utils.isSigma() then internal else external
        Utils.request url, (event) =>
            @propertyData           = document.createElement "div"
            @propertyData.innerHTML = event.data
            @_combine() if @positionData
            @_handleLoad()

    _combine: =>
        for pos in @positionData
            id   = pos.id.toLowerCase()
            prop = @_getPropertyById id
            continue unless prop
            @data.units.push
                id       : id
                shape    : pos.shape
                coords   : pos.coords
                occupant : prop.occupant
                color    : prop.color
                fields   : prop.fields

    _getSizeData: =>
        @_loadBackgroundImage()
        @_loadForegroundImage()

    _loadBackgroundImage: =>
        img        = new Image()
        img.src    = @data.urls.background
        img.onload = =>
            @data.width  = img.width
            @data.height = img.height
            @_handleLoad()

    _loadForegroundImage: =>
        img     = new Image()
        img.src = @data.urls.foreground
        img.onload = =>
            @_handleLoad()

    _handleLoad: =>
        return if ++@loadCount isnt 4
        @dispatchEvent Event.READY

    _getPropertyById: (id) =>
        for elem in @propertyData.getElementsByTagName("unit")
            prop          = {}
            prop.id       = elem.getElementsByTagName("unitnumber")[0].textContent
            continue unless typeof prop.id is "string"
            prop.id       = prop.id.toLowerCase().replace(/\ /g, "_")
            continue unless prop.id is id
            prop.occupant = elem.getElementsByTagName("occupant")[0].textContent
            prop.color    = "#" + elem.getElementsByTagName("color")[0].textContent
            prop.fields   = []
            for field in elem.getElementsByTagName("item")
                label = field.getAttribute "label"
                value = field.getAttribute "val"
                prop.fields.push label:label, value:value
            return prop
