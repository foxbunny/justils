// Generated by LiveScript 1.2.0
describe('utils.matchClass', function(){
  var x$;
  x$ = it;
  beforeEach(function(){
    setFixtures("<p id=\"hasfoo\" class=\"foo\"></p>");
  });
  afterEach(function(){
    utils.byId.clearCache();
  });
  x$('should return element if it has matching class', function(){
    var el;
    el = utils.byId('hasfoo');
    expect(utils.matchClass('foo', el)).toBe(el);
    expect(utils.matchClass('bar', el)).toBe(void 8);
  });
  x$('should be curried', function(){
    var el, hasFoo;
    el = utils.byId('hasfoo');
    hasFoo = utils.matchClass('foo');
    expect(hasFoo(el)).toBe(el);
  });
});
describe('utils.matchAttr', function(){
  var x$;
  x$ = it;
  beforeEach(function(){
    setFixtures("<p id=\"hastitle\" title=\"foo\"></p>");
  });
  afterEach(function(){
    utils.byId.clearCache();
  });
  x$('should return true if element has matching attribute', function(){
    var el;
    el = utils.byId('hastitle');
    expect(utils.matchAttr('title', 'foo', el)).toBe(el);
    expect(utils.matchAttr('title', 'bar', el)).toBe(void 8);
  });
  x$('should return false for non-existent attributes', function(){
    var el;
    el = utils.byId('hastitle');
    expect(utils.matchAttr('href', 'http://example.com/', el)).toBe(void 8);
  });
  x$('should be curried', function(){
    var el, matchTitle, matchFoo;
    el = utils.byId('hastitle');
    matchTitle = utils.matchAttr('title');
    expect(matchTitle('foo', el)).toBe(el);
    expect(matchTitle('bar', el)).toBe(void 8);
    matchFoo = utils.matchAttr('title', 'foo');
    expect(matchFoo(el)).toBe(el);
  });
});
describe('utils.match-selector', function(){
  var x$;
  x$ = it;
  beforeEach(function(){
    setFixtures("<p id=\"foo\" class=\"foo\"></p>");
  });
  afterEach(function(){
    utils.byId.clearCache();
  });
  x$('should return element if it matches selector', function(){
    var el;
    el = utils.byId('foo');
    expect(utils.matchSelector('p.foo', el)).toBe(el);
    expect(utils.matchSelector('div.foo', el)).toBe(void 8);
  });
  x$('should be curried', function(){
    var el, isPFoo;
    el = utils.byId('foo');
    isPFoo = utils.matchSelector('p.foo');
    expect(isPFoo(el)).toBe(el);
  });
});