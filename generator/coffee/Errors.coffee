class Equity.Errors extends Array

    constructor: ->

    log: =>

        for item in @
            log item

    alert: =>
        message = "Export Complete\n"
        for item in @
            message += String(item) + "\n"
        if message.length > 0
            alert message
        else
            alert "Export Complete"


