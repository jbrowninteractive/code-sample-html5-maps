class Equity.XmlData

    constructor: (@property) ->
        @path  = "#{main.path}/exports/data/xml/#{@property.id}.xml"
        @file  = new File @path
        @units = []

    export: (@callback) =>
        @file.remove()
        @_requestData()

    _requestData: =>
        script =
        "
        new ExternalObject('lib:webaccesslib');
        var url  = 'http://www.equityone.net/tools/xmlgen.aspx?ID=#{@property.id}';
        var http = new HttpConnection(url);
        http.execute();
        http.close();
        var url  = 'http://www.equityone.net/tools/p_#{@property.id}.xml';
        var http = new HttpConnection(url);
        var path = '#{@path}';
        var file = new File(path);
        http.response = file;
        http.execute();
        http.response.close();
        http.close();
        "
        talk        = new BridgeTalk()
        talk.target = "bridge"
        talk.body   = script
        talk.send()
        @_readData()

    _readData: =>
        unless @file.exists
            $.sleep 200
            @_readData()
            return
        $.sleep 200 # give the file a break before reading
        @file.open "r"
        @raw  = @file.read()
        @data = new XML @raw
        @_parseData()

    _parseData: =>
        children = @data.elements()
        length   = children.length()
        for [0...children.length()]
            child = children.child _i
            node  = if length is 1 then child.parent() else child
            id    = node.unitNumber.toString()
            color = node.color.toString()
            unit  = id:id, color:color
            @units.push unit
        @file.close()
        @callback()


