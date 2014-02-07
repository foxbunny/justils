describe 'just.matchClass', !-> ``it``

  before-each !->
    set-fixtures """
    <p id="hasfoo" class="foo"></p>
    """

  after-each !->
    just.by-id.clear-cache!

  .. 'should return element if it has matching class', !->
    el = just.by-id \hasfoo
    expect just.match-class \foo, el .to-be el
    expect just.match-class \bar, el .to-be void

  .. 'should be curried', !->
    el = just.by-id \hasfoo
    has-foo = just.match-class \foo
    expect has-foo el .to-be el

  .. 'should not return anything if nothing is passed', !->
    expect just.match-class \foo, null .to-be void


describe 'just.matchAttr', !-> ``it``

  before-each !->
    set-fixtures """
    <p id="hastitle" title="foo"></p>
    """

  after-each !->
    just.by-id.clear-cache!

  .. 'should return true if element has matching attribute', !->
    el = just.by-id \hastitle
    expect just.match-attr \title, \foo, el .to-be el
    expect just.match-attr \title, \bar, el .to-be void

  .. 'should return false for non-existent attributes', !->
    el = just.by-id \hastitle
    expect just.match-attr \href, 'http://example.com/', el .to-be void

  .. 'should be curried', !->
    el = just.by-id \hastitle
    match-title = just.match-attr \title
    expect match-title \foo, el .to-be el
    expect match-title \bar, el .to-be void
    match-foo = just.match-attr \title, \foo
    expect match-foo el .to-be el

  .. 'should not return anything if nothing is passed', !->
    expect just.match-attr \foo, \bar, null .to-be void


describe 'just.matchSelector', !-> ``it``

  before-each !->
    set-fixtures """
    <p id="foo" class="foo"></p>
    """

  after-each !->
    just.by-id.clear-cache!

  .. 'should return element if it matches selector', !->
    el = just.by-id \foo
    expect just.match-selector \p.foo, el .to-be el
    expect just.match-selector \div.foo, el .to-be void

  .. 'should be curried', !->
    el = just.by-id \foo
    is-p-foo = just.match-selector \p.foo
    expect is-p-foo el .to-be el

  .. 'should not return anything if nothing is passed', !->
    expect just.match-selector \bar, null .to-be void


describe 'just.matchAll', !-> ``it``

  before-each !->
    set-fixtures """
    <p id="foo" class="bar" title="baz"></p>
    <p id="notfoo" class="baz" title="bar"></p>
    """

  after-each !->
    just.by-id.clear-cache!

  .. 'should return the element if it matches all matchers', !->
    el = just.by-id \foo
    match-bar = just.match-class \bar
    match-baz = just.match-attr \title, \baz
    match-selector = just.match-selector \p#foo
    matchers = [match-bar, match-baz, match-selector]
    expect just.match-all matchers, el .to-be el

  .. 'should return nothing if at least one matcher fails', !->
    el = just.by-id \foo
    match-bar = just.match-class \bar
    match-baz = just.match-attr \title, \baz
    match-selector = just.match-selector \div#foo
    matchers = [match-bar, match-baz, match-selector]
    expect just.match-all matchers, el .to-be void

  .. 'should be curried', !->
    el1 = just.by-id \foo
    el2 = just.by-id \notfoo
    match-bar = just.match-class \bar
    match-baz = just.match-attr \title, \baz
    match-bar-baz = just.match-all [match-bar, match-baz]
    expect match-bar-baz el1 .to-be el1
    expect match-bar-baz el2 .to-be void

  .. 'should return nothing if nothing is passed', !->
    match-bar = just.match-class \bar
    match-baz = just.match-attr \title, \baz
    matchers = [match-bar, match-baz]
    expect just.match-all matchers, null .to-be void


describe 'just.filter', !-> ``it``

  before-each !->
    set-fixtures """
    <p class="foo" title="bar"></p>
    <p class="foo" title="bar"></p>
    <p class="foo" title="bar"></p>
    <p class="bar" title="foo"></p>
    """

  after-each !->
    just.by-id.clear-cache!

  .. 'should return a filtered list of elements', !->
    elements = just.by-tag \p, document
    match-foo = just.match-class \foo
    match-bar = just.match-attr \title, \bar
    matchers = [match-foo, match-bar]
    filtered = just.filter matchers, elements
    expect filtered.length .to-equal 3

  .. 'should return empty array if no element matches', !->
    elements = just.by-tag \p, document
    match-bar = just.match-class \bar
    match-baz = just.match-attr \title, \baz
    matchers = [match-bar, match-baz]
    filtered = just.filter matchers, elements
    expect filtered.length .to-equal 0

  .. 'should return nothing if matchers are missing', !->
    elements = just.by-tag \p, document
    expect just.filter [], elements .to-equal void
    expect just.filter null, elements .to-equal void

  .. 'should return nothing if elements are missing' !->
    match-foo = just.match-class \foo
    match-bar = just.match-attr \title, \bar
    matchers = [match-foo, match-bar]
    expect just.filter matchers, [] .to-equal void
    expect just.filter matchers, null .to-equal void

  .. 'should be curried', !->
    elements = just.by-tag \p, document
    match-foo = just.match-class \foo
    match-bar = just.match-attr \title, \bar
    matchers = [match-foo, match-bar]
    filter-foo-bar = just.filter matchers
    filtered = filter-foo-bar elements
    expect filtered.length .to-equal 3
