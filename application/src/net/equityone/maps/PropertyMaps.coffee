import net.equityone.maps.model.PropertyModel
import net.equityone.maps.view.PropertyView
import net.equityone.maps.controller.PropertyController
import net.equityone.maps.event.Event

class PropertyMaps

    constructor: ->
        @model      = new PropertyModel()
        @view       = new PropertyView()
        @controller = new PropertyController @model, @view
        @controller.init()


window.propertyMaps = new net.equityone.maps.PropertyMaps();
