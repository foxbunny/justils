// Generated by LiveScript 1.2.0
var fixtures;
fixtures = jasmine.getFixtures();
describe('utils.byId', function(){
  var x$;
  x$ = it;
  beforeEach(function(){
    return fixtures.set("<p id=\"foo\">inner</p>\n<p id=\"bar\">bar inner</p>\n<p id=\"baz\">baz inner</p>\n<p id=\"nocache\">isn't cached</p>\n<p>not matched</p>");
  });
  x$('should retrieve element by id', function(){
    var el;
    el = utils.byId('foo');
    expect(el).toExist();
    expect(el).toHaveId('foo');
    expect(el).toHaveHtml('inner');
  });
  x$('should only call getElementById once for each id', function(){
    spyOn(document, 'getElementById').andCallThrough();
    utils.byId('bar');
    utils.byId('bar');
    utils.byId('baz');
    utils.byId('baz');
    expect(document.getElementById.callCount).toBe(2);
    expect(document.getElementById.argsForCall).toEqual([['bar'], ['baz']]);
  });
  x$('should have a clearCache method on function', function(){
    expect(typeof utils.byId.clearCache).toBe('function');
  });
  x$('should reset cache by calling clearCache', function(){
    spyOn(document, 'getElementById').andCallThrough();
    utils.byId('nocache');
    utils.byId.clearCache();
    utils.byId('nocache');
    expect(document.getElementById.callCount).toBe(2);
    expect(document.getElementById.argsForCall).toEqual([['nocache'], ['nocache']]);
  });
});
describe('utils.byClass', function(){
  var x$;
  x$ = it;
  beforeEach(function(){
    return fixtures.set("<ul class=\"list\" id=\"first\">\n  <li class=\"list-item\" id=\"1\"></li>\n  <li class=\"list-item\" id=\"2\"></li>\n</ul>\n<ul class=\"list\" id=\"second\">\n  <li class=\"list-item\" id=\"3\"></li>\n  <li class=\"list-item\" id=\"4\"></li>\n</ul>\n<div id=\"mixed\">\n  <p class=\"foo\"></p>\n  <p class=\"bar\"></p>\n  <ul>\n    <li class=\"list-item\"></li>\n    <li class=\"list-item\"></li>\n  </ul>\n</div>");
  });
  x$('should select elements by class', function(){
    var elems, i$, len$, el;
    elems = utils.byClass(document, 'list-item');
    expect(elems.length).toEqual(6);
    for (i$ = 0, len$ = elems.length; i$ < len$; ++i$) {
      el = elems[i$];
      expect(el).toExist();
    }
  });
  x$('first argument should limit scope', function(){
    var root, elems;
    root = utils.byId('first');
    elems = utils.byClass(root, 'list-item');
    expect(elems.length).toEqual(2);
    expect(elems[0]).toHaveId('1');
    expect(elems[1]).toHaveId('2');
    root = utils.byId('second');
    elems = utils.byClass(root, 'list-item');
    expect(elems.length).toEqual(2);
    expect(elems[0]).toHaveId('3');
    expect(elems[1]).toHaveId('4');
  });
  x$('should be curried', function(){
    var root, partial, elems;
    root = utils.byId('mixed');
    partial = utils.byClass(root);
    elems = partial('list-item');
    expect(elems.length).toEqual(2);
    elems = partial('foo');
    expect(elems.length).toEqual(1);
    elems = partial('bar');
    expect(elems.length).toEqual(1);
  });
});