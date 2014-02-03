describe 'utils.byId', !-> ``it``

  before-each !->
    set-fixtures """
      <p id="foo">inner</p>
      <p id="bar">bar inner</p>
      <p id="baz">baz inner</p>
      <p id="nocache">isn't cached</p>
      <p>not matched</p>
      <p id="disabled-caching"></p>
    """

  .. 'should retrieve element by id', !->
    el = utils.by-id \foo
    expect el .to-exist!
    expect el .to-have-id \foo
    expect el .to-have-html 'inner'

  .. 'should only call getElementById once for each id', !->
    spy-on document, 'getElementById' .and-call-through!
    utils.by-id \bar
    utils.by-id \bar
    utils.by-id \baz
    utils.by-id \baz
    expect document.get-element-by-id.call-count .to-be 2
    expect document.get-element-by-id.args-for-call .to-equal [[\bar], [\baz]]

  .. 'should have a clearCache method on function', !->
    expect typeof utils.by-id.clear-cache .to-be \function

  .. 'should reset cache by calling clearCache', !->
    spy-on document, 'getElementById' .and-call-through!
    utils.by-id \nocache
    utils.by-id.clear-cache!
    utils.by-id \nocache
    expect document.get-element-by-id.call-count .to-be 2
    expect document.get-element-by-id.args-for-call .to-equal [
      [\nocache]
      [\nocache]
    ]

  .. 'last argument disables caching', !->
    spy-on document, 'getElementById' .and-call-through!
    utils.by-id \disabled-caching, false
    utils.by-id \disabled-caching, false
    expect document.get-element-by-id.call-count .to-be 2
    expect document.get-element-by-id.args-for-call .to-equal [
      [\disabled-caching]
      [\disabled-caching]
    ]

describe 'utils.byClass', !-> ``it``

  before-each !->
    set-fixtures """
      <ul class="list" id="first">
        <li class="list-item" id="1"></li>
        <li class="list-item" id="2"></li>
      </ul>
      <ul class="list" id="second">
        <li class="list-item" id="3"></li>
        <li class="list-item" id="4"></li>
      </ul>
      <div id="mixed">
        <p class="foo"></p>
        <p class="bar"></p>
        <ul>
          <li class="list-item"></li>
          <li class="list-item"></li>
          <li class="list-item"></li>
          <li class="list-item"></li>
        </ul>
      </div>
    """

  after-each ->
    utils.by-id.clear-cache!

  .. 'should select elements by class', !->
    elems = utils.by-class \list-item, document
    elems = [e for e in elems]
    expect elems.length .to-equal 8
    for el in elems
      expect el .to-exist!

  .. 'last argument should limit scope', !->
    root = utils.by-id \first
    elems = utils.by-class \list-item, root
    expect elems.length .to-equal 2
    expect elems.0 .to-have-id \1
    expect elems.1 .to-have-id \2
    root = utils.by-id \second
    elems = utils.by-class \list-item, root
    expect elems.length .to-equal 2
    expect elems.0 .to-have-id \3
    expect elems.1 .to-have-id \4

  .. 'should be curried', !->
    list-items = utils.by-class \list-item
    root = utils.by-id \mixed
    elems = list-items root
    expect elems.length .to-equal 4
    root = utils.by-id \first
    elems = list-items root
    expect elems.length .to-equal 2


describe 'utils.byTag', !-> ``it``

  before-each !->
    set-fixtures """
    <p></p>
    <p></p>
    <p></p>
    <ul id="list">
      <li></li>
      <li></li>
    </ul>
    <ul id="other-list">
      <li></li>
      <li></li>
      <li></li>
      <li></li>
    </ul>
    <div id="top">
      <p></p>
      <p></p>
      <div id="middle">
        <p></p>
        <p></p>
        <div id="bottom">
          <p></p>
          <p></p>
        </div>
      </div>
    </div>
    """

  .. 'should select elements by tag name', !->
    elems = utils.by-tag \P, document
    expect elems.length .to-equal 9
    for el in elems
      expect el .to-exist!

  .. 'last argument should limit scope', !->
    elems = utils.by-tag \li, utils.by-id \list
    expect elems.length .to-equal 2

  .. 'should be curried', !->
    get-p = utils.by-tag \p
    top = get-p utils.by-id \top
    middle = get-p utils.by-id \middle
    bottom = get-p utils.by-id \bottom
    expect top.length .to-equal 6
    expect middle.length .to-equal 4
    expect bottom.length .to-equal 2

