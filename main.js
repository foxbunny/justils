// Generated by LiveScript 1.2.0
var define;
define = function(root){
  if (typeof root.define === 'function' && root.define.amd) {
    return root.define;
  } else {
    return function(){};
  }
}(this);
define(function(require){
  var helpers, traverse, manipulate, events, filter, justils;
  helpers = require('./helpers');
  traverse = require('./traverse');
  manipulate = require('./manipulate');
  events = require('./events');
  filter = require('./filter');
  justils = {};
  import$(justils, helpers);
  import$(justils, traverse);
  import$(justils, manipulate);
  import$(justils, events);
  import$(justils, filter);
  return justils;
});
function import$(obj, src){
  var own = {}.hasOwnProperty;
  for (var key in src) if (own.call(src, key)) obj[key] = src[key];
  return obj;
}