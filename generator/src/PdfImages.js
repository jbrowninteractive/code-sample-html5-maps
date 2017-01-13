// Generated by CoffeeScript 1.7.1
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Equity.PdfImages = (function() {
  function PdfImages(property) {
    this.property = property;
    this._export = __bind(this._export, this);
    this._getHotSpot = __bind(this._getHotSpot, this);
    this._setupUnits = __bind(this._setupUnits, this);
    this._setupLayers = __bind(this._setupLayers, this);
    this.path = "" + main.path + "/exports/images/pdf/" + this.property.id + ".png";
    this.opts = new ExportOptionsPNG24();
    this.opts.antiAliasing = true;
    this.opts.transparency = false;
    this.opts.artBoardClipping = true;
    this._setupLayers();
    this._setupUnits();
    this._export();
  }

  PdfImages.prototype._setupLayers = function() {
    var i, layer, _i, _ref, _results;
    _results = [];
    for (i = _i = 0, _ref = this.property.doc.layers.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
      layer = this.property.doc.layers[i];
      layer.locked = false;
      switch (layer.name) {
        case "Hotspots":
          _results.push(layer.visible = true);
          break;
        case "Foreground":
          _results.push(layer.visible = true);
          break;
        case "Background":
          _results.push(layer.visible = true);
          break;
        default:
          _results.push(layer.visible = false);
      }
    }
    return _results;
  };

  PdfImages.prototype._setupUnits = function() {
    var color, hotspot, rgb, unit, _i, _len, _ref, _results;
    _ref = this.property.xmlData.units;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      unit = _ref[_i];
      hotspot = this._getHotSpot(unit.id);
      if (hotspot) {
        rgb = hex2rgb("\#" + unit.color);
        color = new RGBColor();
        color.red = rgb.r;
        color.green = rgb.g;
        color.blue = rgb.b;
        _results.push(hotspot.fillColor = color);
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };

  PdfImages.prototype._getHotSpot = function(id) {
    var error, item, _i, _len, _ref;
    _ref = this.property.doc.pathItems;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      item = _ref[_i];
      if (item.name.toLowerCase() === id.toLowerCase()) {
        if (item.parent.name === "Hotspots") {
          return item;
        }
      }
    }
    error = "Could not find unit " + id + " in property " + this.property.id;
    main.errors.push(error);
    return null;
  };

  PdfImages.prototype._export = function() {
    var file;
    file = new File(this.path);
    return this.property.doc.exportFile(file, ExportType.PNG24, this.opts);
  };

  return PdfImages;

})();