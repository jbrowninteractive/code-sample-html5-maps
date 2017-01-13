class Equity.PropertyData

    constructor: (@id) ->
        @url = "equityone.net:80"

    send: =>
        script   = @_createScript()
        response = bridge.executeScript script

    _createScript: =>
        "
        new ExternalObject('lib:webaccesslib');
        var url  = 'http://www.equityone.net/tools/xmlgen.aspx?ID=#{@id}';
        var http = new HttpConnection(url);
        http.execute();
        http.close();
        var url  = 'http://www.equityone.net/tools/p_#{@id}.xml';
        var http = new HttpConnection(url);
        var path = '#{main.path}/exports/data/xml/#{@id}.xml';
        var file = new File(path);
        http.response = file;
        http.execute();
        http.response.close();
        http.close();
        "


