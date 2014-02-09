describe 'just.triger', !-> ``it``

  before-each !->
    set-fixtures """
    <button id="target"></button>
    <input id="target-input"></input>
    """

  after-each !->
    just.by-id.clear-cache!

  const has-touch = \ontouchstart of document.documentElement

  test-trigger = (target, event-name) ->
    target = just.by-id target
    triggered = false
    target["on#{event-name}"] = -> triggered := true
    runs -> just.trigger event-name, target
    waits-for ->
      triggered
    , "#{event-name} event to be triggered", 200ms
    runs -> expect triggered .to-be true

  .. 'should work with mouse event', !->
    test-trigger \target, \click

  .. 'should work with change event', !->
    test-trigger \target-input, \change

  .. 'should work with keyboard event', !->
    test-trigger \target-input, \keydown

  .. 'should work with UI event', !->
    test-trigger \target, \scroll

  if has-touch
    .. 'should work with touch event', !->
      test-trigger \target, \touchstart
  else
    console?.log? "Not performing touch event test, not supported"

  .. 'should pass extra data', !->
    # FIXME: This fails on IE8 only. It wipes out any customization we make to
    # the event object before we pass it to `fireEvent` method. It's a minor
    # feature, we we leave it as is for now. We'll possibly fix this in a
    # future release, or maybe not. At any rate, it's not making into 0.0.1
    # release.
    target = just.by-id \target
    triggered = false
    extras = null
    target.onclick = (e) ->
      triggered := true
      extras := e.extras

    runs -> just.trigger \click, target, extras: \foobar
    waits-for ->
      triggered isnt false
    , "click event to be triggered", 200ms
    runs -> expect extras .to-be \foobar

  .. 'should be curried', !->
    target = just.by-id \target
    fire-click = just.trigger \click
    triggered = false
    target.onclick = (e) ->
      triggered := true

    runs -> fire-click target
    waits-for ->
      triggered isnt false
    , "click event to be triggered", 200ms
    runs -> expect triggered .to-be true


describe 'just.addListener', !-> ``it``

  before-each !->
    set-fixtures """
    <button id="target"></button
    """

  after-each !->
    just.by-id.clear-cache!

  .. 'should add an event listener', !->
    target = just.by-id \target
    triggered = false
    just.add-listener \click, target, -> triggered := true
    runs -> just.trigger \click, target
    waits-for ->
      triggered isnt false
    , 'click event to be triggered', 200ms
    runs -> expect triggered .to-be true

  .. 'should be curried', !->
    target = just.by-id \target
    triggered = false
    on-click = just.add-listener \click
    on-click target, -> triggered := true
    runs -> just.trigger \click, target
    waits-for ->
      triggered isnt false
    , 'click event to be triggered', 200ms
    runs -> expect triggered .to-be true

  .. 'should attach more than one listener to same target', !->
    target = just.by-id \target
    triggered1 = false
    triggered2 = false
    on-target-click = just.add-listener \click, target
    on-target-click -> triggered1 := true
    on-target-click -> triggered2 := true
    runs -> just.trigger \click, target
    waits-for ->
      triggered1 isnt false && triggered2 isnt false
    , 'click event to be triggered', 200ms
    runs ->
      expect triggered1 .to-be true
      expect triggered2 .to-be true


describe 'just.removeListener', !-> ``it``

  before-each !->
    set-fixtures """
    <button id="target"></button
    """

  after-each !->
    just.by-id.clear-cache!

  .. 'should remove previously attached listeners', !->
    target = just.by-id \target
    triggered = false
    control-triggered = false
    on-target-click = just.add-listener \click, target
    fn = -> triggered := true
    on-target-click fn
    just.remove-listener \click, target, fn
    on-target-click -> control-triggered := true
    runs -> just.trigger \click target
    waits-for ->
      control-triggered isnt false
    , 'control handler to be triggered', 200ms
    runs ->
      expect control-triggered .to-be true
      expect triggered .to-be false

  .. 'should be curried', !->
    target = just.by-id \target
    triggered = false
    control-triggered = false
    on-target-click = just.add-listener \click, target
    remove-target-click = just.remove-listener \click, target
    fn = -> triggered := true
    on-target-click fn
    remove-target-click fn
    on-target-click -> control-triggered := true
    runs -> just.trigger \click target
    waits-for ->
      control-triggered isnt false
    , 'control handler to be triggered', 200ms
    runs ->
      expect control-triggered .to-be true
      expect triggered .to-be false


describe 'just.evt', !-> ``it``

  .. 'should leave irrelevant properties intact', !->
    e = just.evt foo: \bar
    expect e.foo .to-be \bar

  .. 'should add missing event target', !->
    e = src-element: \foo
    e = just.evt e
    expect e.target .to-be \foo

  .. 'should add missing `preventDefault` method', !->
    e = just.evt {}
    expect e.return-value .not.to-be-defined!
    e.prevent-default!
    expect e.return-value .to-be false

  .. 'should add missing `stopPropagation` method', !->
    e = just.evt {}
    expect e.cancel-bubble .not.to-be-defined!
    e.stop-propagation!
    expect e.cancel-bubble .to-be true

  .. 'should add missing `which` property', !->
    e = just.evt key-code: 12
    expect e.which .to-be 12

  .. 'should add missing `key-code` property', !->
    e = just.evt which: 27
    expect e.key-code .to-be 27

  .. 'should add `key-char` property', !->
    e = just.evt which: 65
    expect e.key-char .to-be \A

  .. 'should call `preventDefault` if second argument is `true`', !->
    called = false
    e = prevent-default: -> called := true
    e = just.evt e, true
    expect called .to-be true

  .. 'should call `preventDefault` even if it is not defined initially', !->
    e = just.evt {}, true
    expect e.return-value .to-be false

  .. 'should call `stopPropagation` if third argument is `true`', !->
    called = false
    e = stop-propagation: -> called := true
    e = just.evt e, false, true
    expect called .to-be true

  .. 'should call `stopPropagation` even if it is not defined initially', !->
    e = just.evt {}, false, true
    expect e.cancel-bubble .to-be true
