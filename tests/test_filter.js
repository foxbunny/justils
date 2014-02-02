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
  x$('should not return anything if nothing is passed', function(){
    expect(utils.matchClass('foo', null)).toBe(void 8);
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
  x$('should not return anything if nothing is passed', function(){
    expect(utils.matchAttr('foo', 'bar', null)).toBe(void 8);
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
  x$('should not return anything if nothing is passed', function(){
    expect(utils.matchSelector('bar', null)).toBe(void 8);
  });
});
describe('utils.matchAll', function(){
  var x$;
  x$ = it;
  beforeEach(function(){
    setFixtures("<p id=\"foo\" class=\"bar\" title=\"baz\"></p>\n<p id=\"notfoo\" class=\"baz\" title=\"bar\"></p>");
  });
  afterEach(function(){
    utils.byId.clearCache();
  });
  x$('should return the element if it matches all matchers', function(){
    var el, matchBar, matchBaz, matchSelector, matchers;
    el = utils.byId('foo');
    matchBar = utils.matchClass('bar');
    matchBaz = utils.matchAttr('title', 'baz');
    matchSelector = utils.matchSelector('p#foo');
    matchers = [matchBar, matchBaz, matchSelector];
    expect(utils.matchAll(matchers, el)).toBe(el);
  });
  x$('should return nothing if at least one matcher fails', function(){
    var el, matchBar, matchBaz, matchSelector, matchers;
    el = utils.byId('foo');
    matchBar = utils.matchClass('bar');
    matchBaz = utils.matchAttr('title', 'baz');
    matchSelector = utils.matchSelector('div#foo');
    matchers = [matchBar, matchBaz, matchSelector];
    expect(utils.matchAll(matchers, el)).toBe(void 8);
  });
  x$('should be curried', function(){
    var el1, el2, matchBar, matchBaz, matchBarBaz;
    el1 = utils.byId('foo');
    el2 = utils.byId('notfoo');
    matchBar = utils.matchClass('bar');
    matchBaz = utils.matchAttr('title', 'baz');
    matchBarBaz = utils.matchAll([matchBar, matchBaz]);
    expect(matchBarBaz(el1)).toBe(el1);
    expect(matchBarBaz(el2)).toBe(void 8);
  });
  x$('should return nothing if nothing is passed', function(){
    var matchBar, matchBaz, matchers;
    matchBar = utils.matchClass('bar');
    matchBaz = utils.matchAttr('title', 'baz');
    matchers = [matchBar, matchBaz];
    expect(utils.matchAll(matchers, null)).toBe(void 8);
  });
});