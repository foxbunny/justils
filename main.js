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
  var helpers, traverse, manipulate, events, filter, just;
  helpers = require('./lib/helpers');
  traverse = require('./lib/traverse');
  manipulate = require('./lib/manipulate');
  events = require('./lib/events');
  filter = require('./lib/filter');
  just = {};
  import$(just, helpers);
  import$(just, traverse);
  import$(just, manipulate);
  import$(just, events);
  import$(just, filter);
  return just;
});
function import$(obj, src){
  var own = {}.hasOwnProperty;
  for (var key in src) if (own.call(src, key)) obj[key] = src[key];
  return obj;
}