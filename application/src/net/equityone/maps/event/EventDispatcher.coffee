class EventDispatcher

    constructor: (@listeners = []) ->

    addEventListener: (type, callback) =>
        listener = type:type, callback:callback
        @listeners.push listener

    removeEventListener: (type, callback) =>
        for i in [@listeners.length-1...0]
            listener = @listeners[i]
            if listener.type is type and listener.callback is callback
                @listeners.splice i, 1

    dispatchEvent: (type, data = null) =>
        event = target:@, type:type, data:data
        for listener in @listeners
            if listener.type is type
                listener.callback event
