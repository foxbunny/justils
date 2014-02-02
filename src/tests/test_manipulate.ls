describe 'utils.remove', !-> ``it``

  before-each !->
    set-fixtures """
    <p id="for-removal"></p>
    <div class="for-removal"></div>
    <div class="for-removal"></div>
    <div class="for-removal"></div>
    """

  .. 'should remove an element', !->
    utils.remove utils.by-id \for-removal, false
    expect utils.by-id \for-removal .not.to-exist!

  .. 'should remove an array of elements', !->
    utils.remove utils.by-class \for-removal, document
    el = utils.by-class
    expect el.length .to-equal 0


describe 'utils.css', !-> ``it``

  before-each !->
    set-fixtures """
    <div id="style"></div>
    """

  after-each !->
    utils.by-id.clear-cache!

  .. 'should define styles on element', !->
    el = utils.by-id \style
    utils.css \margin, \2px, el
    expect el.style.margin .to-equal \2px

  .. 'should normalize style names', !->
    el = utils.by-id \style
    utils.css \margin-right, \4px, el
    expect el.style.marginRight .to-equal \4px

  .. 'should not set bogus styles', !->
    el = utils.by-id \style
    utils.css \foo, \bar, el
    expect el.style.foo .not.to-be-defined!

  .. 'should be curried', !->
    el = utils.by-id \style
    padding = utils.css \padding
    hide = utils.css \display, \none
    expect el.style.padding .to-equal ''
    expect el.style.display .to-equal ''
    padding \12px, el
    expect el.style.padding .to-equal \12px
    expect el.style.display .to-equal ''
    hide el
    expect el.style.display .to-equal \none


describe 'utils.addClass', !-> ``it``

  before-each !->
    set-fixtures """
    <p id="addclass"></p>
    """

  after-each !->
    utils.by-id.clear-cache!

  .. 'should add a class name to element', !->
    el = utils.by-id \addclass
    utils.add-class \foo, el
    expect el .to-have-class \foo

  .. 'should be curried', !->
    add-bar = utils.add-class \bar
    el = utils.by-id \addclass
    add-bar el
    expect el .to-have-class \bar

  .. 'should add multiple classes', !->
    el = utils.by-id \addclass
    utils.add-class 'one two three', el
    expect el .to-have-class \one
    expect el .to-have-class \two
    expect el .to-have-class \three

  .. 'should add multiple classes when passed an array', !->
    el = utils.by-id \addclass
    utils.add-class <[first second third]>, el
    expect el .to-have-class \first
    expect el .to-have-class \second
    expect el .to-have-class \third


describe 'utils.removeClass', !-> ``it``

  before-each ->
    set-fixtures """
    <p id="removeclass" class="foo bar baz"></p>
    <p id="removeclass-multi" class="one two three foo"></p>
    <p id="removeclass-multi-again" class="one two three foo"></p>
    """

  after-each ->
    utils.by-id.clear-cache!

  .. 'should remove class', !->
    el = utils.by-id \removeclass
    utils.remove-class \foo, el
    expect el .not.to-have-class \foo
    expect el .to-have-class \bar
    expect el .to-have-class \baz

  .. 'should be curried', !->
    el = utils.by-id \removeclass
    remove-baz = utils.remove-class \baz
    remove-baz el
    expect el .not.to-have-class \baz

  .. 'should remove multiple classes', !->
    el = utils.by-id \removeclass-multi
    utils.remove-class 'three two one', el
    expect el .not.to-have-class \one
    expect el .not.to-have-class \two
    expect el .not.to-have-class \three

  .. 'should remove multiple classes when argument is an array', !->
    el = utils.by-id \removeclass-multi-again
    utils.remove-class <[two one three]>, el
    expect el .not.to-have-class \one
    expect el .not.to-have-class \two
    expect el .not.to-have-class \three


describe 'utils.hasClass', !-> ``it``

  before-each !->
    set-fixtures """
    <div id="hasclass" class="foo bar"></div>
    <div id="noclass"></div>
    """

  .. 'should test if element has class', !->
    el = utils.by-id \hasclass
    expect utils.has-class \foo, el .to-be true
    expect utils.has-class \baz, el .to-be false

  .. 'should be curried', !->
    el1 = utils.by-id \hasclass
    el2 = utils.by-id \noclass
    has-bar = utils.has-class \bar
    expect has-bar el1 .to-be true
    expect has-bar el2 .to-be false


describe 'utils.data', !-> ``it``

  before-each !->
    set-fixtures """
    <p id="nodata"></p>
    <p id="data" data-foo="bar"></p>
  """

  .. 'should retrieve data', !->
    el = utils.by-id \data
    expect utils.data \foo, el .to-equal \bar

  .. 'should be curried', !->
    el = utils.by-id \data
    get-foo = utils.data \foo
    expect get-foo el .to-equal \bar


describe 'utils.setData', !-> ``it``

  before-each !->
    set-fixtures """
    <p id="setdata"></p>
    """

  after-each !->
    utils.by-id.clear-cache!

  .. 'should set data attribute', !->
    el = utils.by-id \setdata
    utils.set-data \foo, el, \bar
    expect utils.data \foo, el .to-equal \bar

  .. 'should be curried', !->
    el = utils.by-id \setdata
    set-bar = utils.set-data \bar
    set-bar el, \baz
    expect utils.data \bar, el .to-equal \baz
    set-baz-on-el = utils.set-data \baz, el
    set-baz-on-el \foobar
    expect utils.data \baz, el .to-equal \foobar
