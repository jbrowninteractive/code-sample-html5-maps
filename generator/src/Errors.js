// Generated by CoffeeScript 1.7.1
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Equity.Errors = (function(_super) {
  __extends(Errors, _super);

  function Errors() {
    this.alert = __bind(this.alert, this);
    this.log = __bind(this.log, this);
  }

  Errors.prototype.log = function() {
    var item, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = this.length; _i < _len; _i++) {
      item = this[_i];
      _results.push(log(item));
    }
    return _results;
  };

  Errors.prototype.alert = function() {
    var item, message, _i, _len;
    message = "Export Complete\n";
    for (_i = 0, _len = this.length; _i < _len; _i++) {
      item = this[_i];
      message += String(item) + "\n";
    }
    if (message.length > 0) {
      return alert(message);
    } else {
      return alert("Export Complete");
    }
  };

  return Errors;

})(Array);
