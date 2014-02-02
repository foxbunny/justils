// Generated by LiveScript 1.2.0
describe('utils.remove', function(){
  var x$;
  x$ = it;
  beforeEach(function(){
    setFixtures("<p id=\"for-removal\"></p>\n<div class=\"for-removal\"></div>\n<div class=\"for-removal\"></div>\n<div class=\"for-removal\"></div>");
  });
  x$('should remove an element', function(){
    utils.remove(utils.byId('for-removal', false));
    expect(utils.byId('for-removal')).not.toExist();
  });
  x$('should remove an array of elements', function(){
    var el;
    utils.remove(utils.byClass('for-removal', document));
    el = utils.byClass;
    expect(el.length).toEqual(0);
  });
});
describe('utils.css', function(){
  var x$;
  x$ = it;
  beforeEach(function(){
    setFixtures("<div id=\"style\"></div>");
  });
  afterEach(function(){
    utils.byId.clearCache();
  });
  x$('should define styles on element', function(){
    var el;
    el = utils.byId('style');
    utils.css('margin', '2px', el);
    expect(el.style.margin).toEqual('2px');
  });
  x$('should normalize style names', function(){
    var el;
    el = utils.byId('style');
    utils.css('margin-right', '4px', el);
    expect(el.style.marginRight).toEqual('4px');
  });
  x$('should not set bogus styles', function(){
    var el;
    el = utils.byId('style');
    utils.css('foo', 'bar', el);
    expect(el.style.foo).not.toBeDefined();
  });
  x$('should be curried', function(){
    var el, padding, hide;
    el = utils.byId('style');
    padding = utils.css('padding');
    hide = utils.css('display', 'none');
    expect(el.style.padding).toEqual('');
    expect(el.style.display).toEqual('');
    padding('12px', el);
    expect(el.style.padding).toEqual('12px');
    expect(el.style.display).toEqual('');
    hide(el);
    expect(el.style.display).toEqual('none');
  });
});
describe('utils.addClass', function(){
  var x$;
  x$ = it;
  beforeEach(function(){
    setFixtures("<p id=\"addclass\"></p>");
  });
  afterEach(function(){
    utils.byId.clearCache();
  });
  x$('should add a class name to element', function(){
    var el;
    el = utils.byId('addclass');
    utils.addClass('foo', el);
    expect(el).toHaveClass('foo');
  });
  x$('should be curried', function(){
    var addBar, el;
    addBar = utils.addClass('bar');
    el = utils.byId('addclass');
    addBar(el);
    expect(el).toHaveClass('bar');
  });
  x$('should add multiple classes', function(){
    var el;
    el = utils.byId('addclass');
    utils.addClass('one two three', el);
    expect(el).toHaveClass('one');
    expect(el).toHaveClass('two');
    expect(el).toHaveClass('three');
  });
  x$('should add multiple classes when passed an array', function(){
    var el;
    el = utils.byId('addclass');
    utils.addClass(['first', 'second', 'third'], el);
    expect(el).toHaveClass('first');
    expect(el).toHaveClass('second');
    expect(el).toHaveClass('third');
  });
});
describe('utils.removeClass', function(){
  var x$;
  x$ = it;
  beforeEach(function(){
    return setFixtures("<p id=\"removeclass\" class=\"foo bar baz\"></p>\n<p id=\"removeclass-multi\" class=\"one two three foo\"></p>\n<p id=\"removeclass-multi-again\" class=\"one two three foo\"></p>");
  });
  afterEach(function(){
    return utils.byId.clearCache();
  });
  x$('should remove class', function(){
    var el;
    el = utils.byId('removeclass');
    utils.removeClass('foo', el);
    expect(el).not.toHaveClass('foo');
    expect(el).toHaveClass('bar');
    expect(el).toHaveClass('baz');
  });
  x$('should be curried', function(){
    var el, removeBaz;
    el = utils.byId('removeclass');
    removeBaz = utils.removeClass('baz');
    removeBaz(el);
    expect(el).not.toHaveClass('baz');
  });
  x$('should remove multiple classes', function(){
    var el;
    el = utils.byId('removeclass-multi');
    utils.removeClass('three two one', el);
    expect(el).not.toHaveClass('one');
    expect(el).not.toHaveClass('two');
    expect(el).not.toHaveClass('three');
  });
  x$('should remove multiple classes when argument is an array', function(){
    var el;
    el = utils.byId('removeclass-multi-again');
    utils.removeClass(['two', 'one', 'three'], el);
    expect(el).not.toHaveClass('one');
    expect(el).not.toHaveClass('two');
    expect(el).not.toHaveClass('three');
  });
});
describe('utils.hasClass', function(){
  var x$;
  x$ = it;
  beforeEach(function(){
    setFixtures("<div id=\"hasclass\" class=\"foo bar\"></div>\n<div id=\"noclass\"></div>");
  });
  x$('should test if element has class', function(){
    var el;
    el = utils.byId('hasclass');
    expect(utils.hasClass('foo', el)).toBe(true);
    expect(utils.hasClass('baz', el)).toBe(false);
  });
  x$('should be curried', function(){
    var el1, el2, hasBar;
    el1 = utils.byId('hasclass');
    el2 = utils.byId('noclass');
    hasBar = utils.hasClass('bar');
    expect(hasBar(el1)).toBe(true);
    expect(hasBar(el2)).toBe(false);
  });
});
describe('utils.data', function(){
  var x$;
  x$ = it;
  beforeEach(function(){
    setFixtures("<p id=\"nodata\"></p>\n<p id=\"data\" data-foo=\"bar\"></p>");
  });
  x$('should retrieve data', function(){
    var el;
    el = utils.byId('data');
    expect(utils.data('foo', el)).toEqual('bar');
  });
  x$('should be curried', function(){
    var el, getFoo;
    el = utils.byId('data');
    getFoo = utils.data('foo');
    expect(getFoo(el)).toEqual('bar');
  });
});
describe('utils.setData', function(){
  var x$;
  x$ = it;
  beforeEach(function(){
    setFixtures("<p id=\"setdata\"></p>");
  });
  afterEach(function(){
    utils.byId.clearCache();
  });
  x$('should set data attribute', function(){
    var el;
    el = utils.byId('setdata');
    utils.setData('foo', el, 'bar');
    expect(utils.data('foo', el)).toEqual('bar');
  });
  x$('should be curried', function(){
    var el, setBar, setBazOnEl;
    el = utils.byId('setdata');
    setBar = utils.setData('bar');
    setBar(el, 'baz');
    expect(utils.data('bar', el)).toEqual('baz');
    setBazOnEl = utils.setData('baz', el);
    setBazOnEl('foobar');
    expect(utils.data('baz', el)).toEqual('foobar');
  });
});
describe('utils.attr', function(){
  var x$;
  x$ = it;
  beforeEach(function(){
    setFixtures("<a id=\"gethref\" href=\"http://example.com/\" title=\"Example\"></a>");
  });
  afterEach(function(){
    utils.byId.clearCache();
  });
  x$('should return html attribute', function(){
    var el;
    el = utils.byId('gethref');
    expect(utils.attr('href', el)).toEqual('http://example.com/');
  });
  x$('should be curried', function(){
    var el, title;
    el = utils.byId('gethref');
    title = utils.attr('title');
    expect(title(el)).toEqual('Example');
  });
});
describe('utils.setAttribute', function(){
  var x$;
  x$ = it;
  beforeEach(function(){
    setFixtures("<a id=\"sethref\"></a>");
  });
  afterEach(function(){
    utils.byId.clearCache();
  });
  x$('should set attribute on element', function(){
    var el;
    el = utils.byId('sethref');
    utils.setAttr('href', el, 'http://example.com/');
    expect(utils.attr('href', el)).toEqual('http://example.com/');
  });
  x$('should be curried', function(){
    var el, setHref, setHrefOnEl;
    el = utils.byId('sethref');
    setHref = utils.setAttr('href');
    setHref(el, 'http://test.com/');
    expect(utils.attr('href', el)).toEqual('http://test.com/');
    setHrefOnEl = utils.setAttr('href', el);
    setHrefOnEl('http://www.test.com/');
    expect(utils.attr('href', el)).toEqual('http://www.test.com/');
  });
});
describe('utils.hasAttr', function(){
  var x$;
  x$ = it;
  beforeEach(function(){
    setFixtures("<a id=\"nohref\"></a>\n<a id=\"hashref\" href=\"http://test.com/\"></a>");
  });
  afterEach(function(){
    utils.byId.clearCache();
  });
  x$('should return true if element has attribute', function(){
    var el1, el2;
    el1 = utils.byId('nohref');
    el2 = utils.byId('hashref');
    expect(utils.hasAttr('href', el1)).toBe(false);
    expect(utils.hasAttr('href', el2)).toBe(true);
  });
  x$('should be curried', function(){
    var el1, el2, hasHref;
    el1 = utils.byId('nohref');
    el2 = utils.byId('hashref');
    hasHref = utils.hasAttr('href');
    expect(hasHref(el1)).toBe(false);
    expect(hasHref(el2)).toBe(true);
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