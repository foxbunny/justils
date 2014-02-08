describe 'just.triger', !-> ``it``

  before-each !->
    set-fixtures """
    <button id="target"></button>
    <input id="target-input"></input>
    """

  const has-touch = window.DocumentTouch? and document instanceof DocumentTouch

  test-trigger = (target, event-name) ->
    target = just.by-id target
    triggered = false
    target["on#{event-name}"] = -> triggered := true
    runs -> just.trigger event-name, target, null
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

