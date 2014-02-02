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

  .. 'should not return anything if nothing is passed', !->
    expect utils.match-class \foo, null .to-be void


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

  .. 'should not return anything if nothing is passed', !->
    expect utils.match-attr \foo, \bar, null .to-be void


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

  .. 'should not return anything if nothing is passed', !->
    expect utils.match-selector \bar, null .to-be void


describe 'utils.matchAll', !-> ``it``

  before-each !->
    set-fixtures """
    <p id="foo" class="bar" title="baz"></p>
    <p id="notfoo" class="baz" title="bar"></p>
    """

  after-each !->
    utils.by-id.clear-cache!

  .. 'should return the element if it matches all matchers', !->
    el = utils.by-id \foo
    match-bar = utils.match-class \bar
    match-baz = utils.match-attr \title, \baz
    match-selector = utils.match-selector \p#foo
    matchers = [match-bar, match-baz, match-selector]
    expect utils.match-all matchers, el .to-be el

  .. 'should return nothing if at least one matcher fails', !->
    el = utils.by-id \foo
    match-bar = utils.match-class \bar
    match-baz = utils.match-attr \title, \baz
    match-selector = utils.match-selector \div#foo
    matchers = [match-bar, match-baz, match-selector]
    expect utils.match-all matchers, el .to-be void

  .. 'should be curried', !->
    el1 = utils.by-id \foo
    el2 = utils.by-id \notfoo
    match-bar = utils.match-class \bar
    match-baz = utils.match-attr \title, \baz
    match-bar-baz = utils.match-all [match-bar, match-baz]
    expect match-bar-baz el1 .to-be el1
    expect match-bar-baz el2 .to-be void

  .. 'should return nothing if nothing is passed', !->
    match-bar = utils.match-class \bar
    match-baz = utils.match-attr \title, \baz
    matchers = [match-bar, match-baz]
    expect utils.match-all matchers, null .to-be void


describe 'utils.filter', !-> ``it``

  before-each !->
    set-fixtures """
    <p class="foo" title="bar"></p>
    <p class="foo" title="bar"></p>
    <p class="foo" title="bar"></p>
    <p class="bar" title="foo"></p>
    """

  after-each !->
    utils.by-id.clear-cache!

  .. 'should return a filtered list of elements', !->
    elements = utils.by-tag \p, document
    match-foo = utils.match-class \foo
    match-bar = utils.match-attr \title, \bar
    matchers = [match-foo, match-bar]
    filtered = utils.filter matchers, elements
    expect filtered.length .to-equal 3

  .. 'should return empty array if no element matches', !->
    elements = utils.by-tag \p, document
    match-bar = utils.match-class \bar
    match-baz = utils.match-attr \title, \baz
    matchers = [match-bar, match-baz]
    filtered = utils.filter matchers, elements
    expect filtered.length .to-equal 0

  .. 'should return nothing if matchers are missing', !->
    elements = utils.by-tag \p, document
    expect utils.filter [], elements .to-equal void
    expect utils.filter null, elements .to-equal void

  .. 'should return nothing if elements are missing' !->
    match-foo = utils.match-class \foo
    match-bar = utils.match-attr \title, \bar
    matchers = [match-foo, match-bar]
    expect utils.filter matchers, [] .to-equal void
    expect utils.filter matchers, null .to-equal void

  .. 'should be curried', !->
    elements = utils.by-tag \p, document
    match-foo = utils.match-class \foo
    match-bar = utils.match-attr \title, \bar
    matchers = [match-foo, match-bar]
    filter-foo-bar = utils.filter matchers
    filtered = filter-foo-bar elements
    expect filtered.length .to-equal 3
