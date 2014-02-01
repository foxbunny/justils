const fixtures = jasmine.get-fixtures!

describe 'utils.byId', !-> ``it``

  before-each ->
    fixtures.set """
      <p id="foo">inner</p>
      <p id="bar">bar inner</p>
      <p id="baz">baz inner</p>
      <p id="nocache">isn't cached</p>
      <p>not matched</p>
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


describe 'utils.byClass', !-> ``it``

  before-each ->
    fixtures.set """
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
        </ul>
      </div>
    """

  .. 'should select elements by class', !->
    elems = utils.by-class document, \list-item
    expect elems.length .to-equal 6
    for el in elems
      expect el .to-exist!

  .. 'first argument should limit scope', !->
    root = utils.by-id \first
    elems = utils.by-class root, \list-item
    expect elems.length .to-equal 2
    expect elems.0 .to-have-id \1
    expect elems.1 .to-have-id \2
    root = utils.by-id \second
    elems = utils.by-class root, \list-item
    expect elems.length .to-equal 2
    expect elems.0 .to-have-id \3
    expect elems.1 .to-have-id \4

  .. 'should be curried', !->
    root = utils.by-id \mixed
    partial = utils.by-class root
    elems = partial \list-item
    expect elems.length .to-equal 2
    elems = partial \foo
    expect elems.length .to-equal 1
    elems = partial \bar
    expect elems.length .to-equal 1

