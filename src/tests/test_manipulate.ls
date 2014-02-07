describe 'just.remove', !-> ``it``

  before-each !->
    set-fixtures """
    <p id="for-removal"></p>
    <div class="for-removal"></div>
    <div class="for-removal"></div>
    <div class="for-removal"></div>
    """

  .. 'should remove an element', !->
    just.remove just.by-id \for-removal, false
    expect just.by-id \for-removal .not.to-exist!

  .. 'should remove an array of elements', !->
    just.remove just.by-class \for-removal, document
    el = just.by-class
    expect el.length .to-equal 0


describe 'just.css', !-> ``it``

  before-each !->
    set-fixtures """
    <div id="style"></div>
    """

  after-each !->
    just.by-id.clear-cache!

  .. 'should define styles on element', !->
    el = just.by-id \style
    just.css \margin, \2px, el
    expect el.style.margin .to-equal \2px

  .. 'should normalize style names', !->
    el = just.by-id \style
    just.css \margin-right, \4px, el
    expect el.style.marginRight .to-equal \4px

  .. 'should not set bogus styles', !->
    el = just.by-id \style
    just.css \foo, \bar, el
    expect el.style.foo .not.to-be-defined!

  .. 'should be curried', !->
    el = just.by-id \style
    padding = just.css \padding
    hide = just.css \display, \none
    expect el.style.padding .to-equal ''
    expect el.style.display .to-equal ''
    padding \12px, el
    expect el.style.padding .to-equal \12px
    expect el.style.display .to-equal ''
    hide el
    expect el.style.display .to-equal \none


describe 'just.addClass', !-> ``it``

  before-each !->
    set-fixtures """
    <p id="addclass"></p>
    """

  after-each !->
    just.by-id.clear-cache!

  .. 'should add a class name to element', !->
    el = just.by-id \addclass
    just.add-class \foo, el
    expect el .to-have-class \foo

  .. 'should be curried', !->
    add-bar = just.add-class \bar
    el = just.by-id \addclass
    add-bar el
    expect el .to-have-class \bar

  .. 'should add multiple classes', !->
    el = just.by-id \addclass
    just.add-class 'one two three', el
    expect el .to-have-class \one
    expect el .to-have-class \two
    expect el .to-have-class \three

  .. 'should add multiple classes when passed an array', !->
    el = just.by-id \addclass
    just.add-class <[first second third]>, el
    expect el .to-have-class \first
    expect el .to-have-class \second
    expect el .to-have-class \third


describe 'just.removeClass', !-> ``it``

  before-each ->
    set-fixtures """
    <p id="removeclass" class="foo bar baz"></p>
    <p id="removeclass-multi" class="one two three foo"></p>
    <p id="removeclass-multi-again" class="one two three foo"></p>
    """

  after-each ->
    just.by-id.clear-cache!

  .. 'should remove class', !->
    el = just.by-id \removeclass
    just.remove-class \foo, el
    expect el .not.to-have-class \foo
    expect el .to-have-class \bar
    expect el .to-have-class \baz

  .. 'should be curried', !->
    el = just.by-id \removeclass
    remove-baz = just.remove-class \baz
    remove-baz el
    expect el .not.to-have-class \baz

  .. 'should remove multiple classes', !->
    el = just.by-id \removeclass-multi
    just.remove-class 'three two one', el
    expect el .not.to-have-class \one
    expect el .not.to-have-class \two
    expect el .not.to-have-class \three

  .. 'should remove multiple classes when argument is an array', !->
    el = just.by-id \removeclass-multi-again
    just.remove-class <[two one three]>, el
    expect el .not.to-have-class \one
    expect el .not.to-have-class \two
    expect el .not.to-have-class \three


describe 'just.hasClass', !-> ``it``

  before-each !->
    set-fixtures """
    <div id="hasclass" class="foo bar"></div>
    <div id="noclass"></div>
    """

  .. 'should test if element has class', !->
    el = just.by-id \hasclass
    expect just.has-class \foo, el .to-be true
    expect just.has-class \baz, el .to-be false

  .. 'should be curried', !->
    el1 = just.by-id \hasclass
    el2 = just.by-id \noclass
    has-bar = just.has-class \bar
    expect has-bar el1 .to-be true
    expect has-bar el2 .to-be false


describe 'just.data', !-> ``it``

  before-each !->
    set-fixtures """
    <p id="nodata"></p>
    <p id="data" data-foo="bar"></p>
  """

  .. 'should retrieve data', !->
    el = just.by-id \data
    expect just.data \foo, el .to-equal \bar

  .. 'should be curried', !->
    el = just.by-id \data
    get-foo = just.data \foo
    expect get-foo el .to-equal \bar


describe 'just.setData', !-> ``it``

  before-each !->
    set-fixtures """
    <p id="setdata"></p>
    """

  after-each !->
    just.by-id.clear-cache!

  .. 'should set data attribute', !->
    el = just.by-id \setdata
    just.set-data \foo, el, \bar
    expect just.data \foo, el .to-equal \bar

  .. 'should be curried', !->
    el = just.by-id \setdata
    set-bar = just.set-data \bar
    set-bar el, \baz
    expect just.data \bar, el .to-equal \baz
    set-baz-on-el = just.set-data \baz, el
    set-baz-on-el \foobar
    expect just.data \baz, el .to-equal \foobar


describe 'just.attr', !-> ``it``

  before-each !->
    set-fixtures """
    <a id="gethref" href="http://example.com/" title="Example"></a>
    """

  after-each !->
    just.by-id.clear-cache!

  .. 'should return html attribute', !->
    el = just.by-id \gethref
    expect just.attr \href, el .to-equal 'http://example.com/'

  .. 'should be curried', !->
    el = just.by-id \gethref
    title = just.attr \title
    expect title el .to-equal \Example


describe 'just.setAttribute', !-> ``it``

  before-each !->
    set-fixtures """
    <a id="sethref"></a>
    """

  after-each !->
    just.by-id.clear-cache!

  .. 'should set attribute on element', !->
    el = just.by-id \sethref
    just.set-attr \href, el, 'http://example.com/'
    expect just.attr \href, el .to-equal 'http://example.com/'

  .. 'should be curried', !->
    el = just.by-id \sethref
    set-href = just.set-attr \href
    set-href el, 'http://test.com/'
    expect just.attr \href, el .to-equal 'http://test.com/'
    set-href-on-el = just.set-attr \href, el
    set-href-on-el 'http://www.test.com/'
    expect just.attr \href, el .to-equal 'http://www.test.com/'


describe 'just.hasAttr', !-> ``it``

  before-each !->
    set-fixtures """
    <a id="nohref"></a>
    <a id="hashref" href="http://test.com/"></a>
    """

  after-each !->
    just.by-id.clear-cache!

  .. 'should return true if element has attribute', !->
    el1 = just.by-id \nohref
    el2 = just.by-id \hashref
    expect just.has-attr \href, el1 .to-be false
    expect just.has-attr \href, el2 .to-be true

  .. 'should be curried', !->
    el1 = just.by-id \nohref
    el2 = just.by-id \hashref
    has-href = just.has-attr \href
    expect has-href el1 .to-be false
    expect has-href el2 .to-be true

