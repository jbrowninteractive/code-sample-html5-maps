class Utils

    @getQuery: (name) ->
        name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]")
        regex = new RegExp("[\\?&]" + name + "=([^&#]*)")
        results = regex.exec(location.search)
        return (if not results? then undefined else decodeURIComponent(results[1].replace(/\+/g, " ")))

    @request: (url, callback) ->
        req  = new XMLHttpRequest()
        req.open "GET", url, true
        req.onreadystatechange = ->
            return if req.readyState isnt 4
            if req.status isnt 200 and req.status isnt 304
                callback error:true
            else
                callback data:req.responseText
        req.send()

    @isSigma = ->
        return location.host.indexOf("sigma.") >  -1

    @getPosition = (obj) ->
        left = 0
        top  = 0
        if obj.offsetParent
            loop
                left += obj.offsetLeft
                top  += obj.offsetTop
                break unless obj = obj.offsetParent
            return x: left, y: top
        return null
