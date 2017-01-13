// Generated by CoffeeScript 1.7.1
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Equity.XmlData = (function() {
  function XmlData(property) {
    this.property = property;
    this._parseData = __bind(this._parseData, this);
    this._readData = __bind(this._readData, this);
    this._requestData = __bind(this._requestData, this);
    this["export"] = __bind(this["export"], this);
    this.path = "" + main.path + "/exports/data/xml/" + this.property.id + ".xml";
    this.file = new File(this.path);
    this.units = [];
  }

  XmlData.prototype["export"] = function(callback) {
    this.callback = callback;
    this.file.remove();
    return this._requestData();
  };

  XmlData.prototype._requestData = function() {
    var script, talk;
    script = "new ExternalObject('lib:webaccesslib'); var url  = 'http://www.equityone.net/tools/xmlgen.aspx?ID=" + this.property.id + "'; var http = new HttpConnection(url); http.execute(); http.close(); var url  = 'http://www.equityone.net/tools/p_" + this.property.id + ".xml'; var http = new HttpConnection(url); var path = '" + this.path + "'; var file = new File(path); http.response = file; http.execute(); http.response.close(); http.close();";
    talk = new BridgeTalk();
    talk.target = "bridge";
    talk.body = script;
    talk.send();
    return this._readData();
  };

  XmlData.prototype._readData = function() {
    if (!this.file.exists) {
      $.sleep(200);
      this._readData();
      return;
    }
    $.sleep(200);
    this.file.open("r");
    this.raw = this.file.read();
    this.data = new XML(this.raw);
    return this._parseData();
  };

  XmlData.prototype._parseData = function() {
    var child, children, color, id, length, node, unit, _i, _ref;
    children = this.data.elements();
    length = children.length();
    for (_i = 0, _ref = children.length(); 0 <= _ref ? _i < _ref : _i > _ref; 0 <= _ref ? _i++ : _i--) {
      child = children.child(_i);
      node = length === 1 ? child.parent() : child;
      id = node.unitNumber.toString();
      color = node.color.toString();
      unit = {
        id: id,
        color: color
      };
      this.units.push(unit);
    }
    this.file.close();
    return this.callback();
  };

  return XmlData;

})();