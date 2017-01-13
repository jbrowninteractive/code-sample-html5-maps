// Generated by CoffeeScript 1.7.1
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Equity.JsonData = (function() {
  function JsonData(property) {
    this.property = property;
    this._formatUnicodeText = __bind(this._formatUnicodeText, this);
    this._formatPoints = __bind(this._formatPoints, this);
    this._parseUnitId = __bind(this._parseUnitId, this);
    this._parseHotspot = __bind(this._parseHotspot, this);
    this._parseHotspotNodes = __bind(this._parseHotspotNodes, this);
    this._getSvg = __bind(this._getSvg, this);
    this._export = __bind(this._export, this);
    this.path = "" + main.path + "/exports/data/json/" + this.property.id + ".json";
    this._export();
  }

  JsonData.prototype._export = function() {
    var file, json, svg;
    svg = this._getSvg();
    json = JSON.stringify(this._parseHotspotNodes(svg));
    file = new File(this.path);
    file.open("w");
    file.write(json);
    return file.close();
  };

  JsonData.prototype._getSvg = function() {
    var file, raw, svg;
    file = new File("" + main.path + "/exports/data/svg/" + this.property.id + ".svg");
    file.open("r");
    raw = file.read();
    svg = new XML(raw);
    file.close();
    return svg;
  };

  JsonData.prototype._parseHotspotNodes = function(node) {
    var child, children, length, object, objects, _i;
    objects = [];
    children = node.elements();
    length = children.length();
    for (_i = 0; 0 <= length ? _i < length : _i > length; 0 <= length ? _i++ : _i--) {
      child = length === 1 ? node.child(_i) : children.child(_i);
      object = this._parseHotspot(child);
      if (object) {
        objects.push(object);
      }
    }
    return objects;
  };

  JsonData.prototype._parseHotspot = function(node) {
    var error, h, id, object, pts, r, w, x, y;
    id = this._parseUnitId(node);
    switch (node.localName()) {
      case "polygon":
        pts = this._formatPoints(node.attribute("points").toString());
        object = {
          shape: "poly",
          id: id,
          coords: pts
        };
        break;
      case "rect":
        x = Number(node.attribute("x"));
        y = Number(node.attribute("y"));
        w = Number(node.attribute("width"));
        h = Number(node.attribute("height"));
        object = {
          shape: "rect",
          id: id,
          coords: "" + x + "," + y + "," + (x + w) + "," + (y + h)
        };
        break;
      case "circle":
        x = Number(node.attribute("cx"));
        y = Number(node.attribute("cy"));
        r = Number(node.attribute("r"));
        object = {
          shape: "circle",
          id: id,
          coords: "" + x + "," + y + "," + r
        };
        break;
      default:
        error = "Invalid Shape: [" + (node.localName()) + "] ";
        error += "used for unit " + id + " in property " + this.property.id;
        main.errors.push(error);
    }
    return object;
  };

  JsonData.prototype._parseUnitId = function(node) {
    var id, parts, raw;
    raw = this._formatUnicodeText(node.attribute("id").toString());
    parts = raw.split("|");
    parts = parts.splice(1, parts.length - 1);
    if (!parts) {
      return;
    }
    id = parts.join("|");
    return id;
  };

  JsonData.prototype._formatPoints = function(points) {
    var part, parts, str, _i, _len;
    str = "";
    parts = points.split(" ");
    for (_i = 0, _len = parts.length; _i < _len; _i++) {
      part = parts[_i];
      if (part !== "") {
        part += ",";
        str += part;
      }
    }
    if (str[str.length - 1] === ",") {
      str = str.substring(0, str.length - 1);
    }
    return str;
  };

  JsonData.prototype._formatUnicodeText = function(id) {
    var c, exp;
    id = id.toLowerCase();
    for (c in this.chars) {
      exp = new RegExp(c, "g");
      id = id.replace(exp, this.chars[c]);
    }
    return id;
  };

  JsonData.prototype.chars = {
    "_x20_": " ",
    "_x21_": "!",
    "_x23_": "#",
    "_x24_": "$",
    "_x25_": "%",
    "_x26_": "&",
    "_x27_": "'",
    "_x28_": "(",
    "_x29_": ")",
    "_x2a_": "*",
    "_x2b_": "+",
    "_x2c_": ",",
    "_x2d_": "-",
    "_x2e_": ".",
    "_x2f_": "/",
    "_x30_": "0",
    "_x31_": "1",
    "_x32_": "2",
    "_x33_": "3",
    "_x34_": "4",
    "_x35_": "5",
    "_x36_": "6",
    "_x37_": "7",
    "_x38_": "8",
    "_x39_": "9",
    "_x3a_": ":",
    "_x3b_": ";",
    "_x3c_": "<",
    "_x3d_": "=",
    "_x3e_": ">",
    "_x3f_": "?",
    "_x40_": "@",
    "_x41_": "A",
    "_x42_": "B",
    "_x43_": "C",
    "_x44_": "D",
    "_x45_": "E",
    "_x46_": "F",
    "_x47_": "G",
    "_x48_": "H",
    "_x49_": "I",
    "_x4a_": "J",
    "_x4b_": "K",
    "_x4c_": "L",
    "_x4d_": "M",
    "_x4e_": "N",
    "_x4f_": "O",
    "_x50_": "P",
    "_x51_": "Q",
    "_x52_": "R",
    "_x53_": "S",
    "_x54_": "T",
    "_x55_": "U",
    "_x56_": "V",
    "_x57_": "W",
    "_x58_": "X",
    "_x59_": "Y",
    "_x5a_": "Z",
    "_x5b_": "[",
    "_x5d_": "]",
    "_x5e_": "^",
    "_x5f_": "_",
    "_x60_": "`",
    "_x61_": "a",
    "_x62_": "b",
    "_x63_": "c",
    "_x64_": "d",
    "_x65_": "e",
    "_x66_": "f",
    "_x67_": "g",
    "_x68_": "h",
    "_x69_": "i",
    "_x6a_": "j",
    "_x6b_": "k",
    "_x6c_": "l",
    "_x6d_": "m",
    "_x6e_": "n",
    "_x6f_": "o",
    "_x70_": "p",
    "_x71_": "q",
    "_x72_": "r",
    "_x73_": "s",
    "_x74_": "t",
    "_x75_": "u",
    "_x76_": "v",
    "_x77_": "w",
    "_x78_": "x",
    "_x79_": "y",
    "_x7a_": "z",
    "_x7b_": "{",
    "_x7c_": "|",
    "_x7d_": "}",
    "_x7e_": "~"
  };

  return JsonData;

})();