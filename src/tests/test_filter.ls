describe 'utils.matchClass', !-> ``it``

  before-each !->
    set-fixtures """
    <p id="hasfoo" class="foo"></p>
    """

  after-each !->
    utils.by-id.clear-cache!

  .. 'should return element if it has matching class', !->
    el = utils.by-id \hasfoo
    expect utils.match-class \foo, el .to-be el
    expect utils.match-class \bar, el .to-be void

  .. 'should be curried', !->
    el = utils.by-id \hasfoo
    has-foo = utils.match-class \foo
    expect has-foo el .to-be el


describe 'utils.matchAttr', !-> ``it``

  before-each !->
    set-fixtures """
    <p id="hastitle" title="foo"></p>
    """

  after-each !->
    utils.by-id.clear-cache!

  .. 'should return true if element has matching attribute', !->
    el = utils.by-id \hastitle
    expect utils.match-attr \title, \foo, el .to-be el
    expect utils.match-attr \title, \bar, el .to-be void

  .. 'should return false for non-existent attributes', !->
    el = utils.by-id \hastitle
    expect utils.match-attr \href, 'http://example.com/', el .to-be void

  .. 'should be curried', !->
    el = utils.by-id \hastitle
    match-title = utils.match-attr \title
    expect match-title \foo, el .to-be el
    expect match-title \bar, el .to-be void
    match-foo = utils.match-attr \title, \foo
    expect match-foo el .to-be el


describe 'utils.match-selector', !-> ``it``

  before-each !->
    set-fixtures """
    <p id="foo" class="foo"></p>
    """

  after-each !->
    utils.by-id.clear-cache!

  .. 'should return element if it matches selector', !->
    el = utils.by-id \foo
    expect utils.match-selector \p.foo, el .to-be el
    expect utils.match-selector \div.foo, el .to-be void

  .. 'should be curried', !->
    el = utils.by-id \foo
    is-p-foo = utils.match-selector \p.foo
    expect is-p-foo el .to-be el
