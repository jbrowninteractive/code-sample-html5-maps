import net.equityone.maps.event.Event

class PropertyController

    constructor: (@model, @view) ->
        @model.addEventListener Event.READY, @_onModelReady

    init: =>
        @model.fetch()

    _onModelReady: =>
        @view.render @model.data
