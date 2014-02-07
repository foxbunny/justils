describe 'just.byId', !-> ``it``

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
    el = just.by-id \foo
    expect el .to-exist!
    expect el .to-have-id \foo
    expect el .to-have-html 'inner'

  .. 'should only call getElementById once for each id', !->
    spy-on document, 'getElementById' .and-call-through!
    just.by-id \bar
    just.by-id \bar
    just.by-id \baz
    just.by-id \baz
    expect document.get-element-by-id.call-count .to-be 2
    expect document.get-element-by-id.args-for-call .to-equal [[\bar], [\baz]]

  .. 'should have a clearCache method on function', !->
    expect typeof just.by-id.clear-cache .to-be \function

  .. 'should reset cache by calling clearCache', !->
    spy-on document, 'getElementById' .and-call-through!
    just.by-id \nocache
    just.by-id.clear-cache!
    just.by-id \nocache
    expect document.get-element-by-id.call-count .to-be 2
    expect document.get-element-by-id.args-for-call .to-equal [
      [\nocache]
      [\nocache]
    ]

  .. 'last argument disables caching', !->
    spy-on document, 'getElementById' .and-call-through!
    just.by-id \disabled-caching, false
    just.by-id \disabled-caching, false
    expect document.get-element-by-id.call-count .to-be 2
    expect document.get-element-by-id.args-for-call .to-equal [
      [\disabled-caching]
      [\disabled-caching]
    ]

describe 'just.byClass', !-> ``it``

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
    just.by-id.clear-cache!

  .. 'should select elements by class', !->
    elems = just.by-class \list-item, document
    elems = [e for e in elems]
    expect elems.length .to-equal 8
    for el in elems
      expect el .to-exist!

  .. 'last argument should limit scope', !->
    root = just.by-id \first
    elems = just.by-class \list-item, root
    expect elems.length .to-equal 2
    expect elems.0 .to-have-id \1
    expect elems.1 .to-have-id \2
    root = just.by-id \second
    elems = just.by-class \list-item, root
    expect elems.length .to-equal 2
    expect elems.0 .to-have-id \3
    expect elems.1 .to-have-id \4

  .. 'should be curried', !->
    list-items = just.by-class \list-item
    root = just.by-id \mixed
    elems = list-items root
    expect elems.length .to-equal 4
    root = just.by-id \first
    elems = list-items root
    expect elems.length .to-equal 2


describe 'just.byTag', !-> ``it``

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
    elems = just.by-tag \P, document
    expect elems.length .to-equal 9
    for el in elems
      expect el .to-exist!

  .. 'last argument should limit scope', !->
    elems = just.by-tag \li, just.by-id \list
    expect elems.length .to-equal 2

  .. 'should be curried', !->
    get-p = just.by-tag \p
    top = get-p just.by-id \top
    middle = get-p just.by-id \middle
    bottom = get-p just.by-id \bottom
    expect top.length .to-equal 6
    expect middle.length .to-equal 4
    expect bottom.length .to-equal 2

