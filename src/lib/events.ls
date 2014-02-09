define = ((root) ->
  if typeof root.define is \function and root.define.amd
    root.define
  else
    (factory) -> (root.just ?= {}) <<< factory -> root.just
) this

define (require) ->

  helpers = require './helpers'

  const IS_BUBBLING = true
  const IS_CANCELABLE = true
  const NOT_CANCELLED = true
  const NO_CAPTURE = false

  # Mapping between event names and event constructors
  EVENT_TYPES: EVENT_TYPES =
    blur: \FocusEvent
    change: \Event
    click: \MouseEvent
    dblclick: \MouseEvent
    drag: \DragEvent
    dragend: \DragEvent
    dragenter: \DragEvent
    dragleave: \DragEvent
    dragover: \DragEvent
    dragstart: \DragEvent
    drop: \DragEvent
    focus: \FocusEvent
    keydown: \KeyboardEvent
    keypress: \KeyboardEvent
    keyup: \KeyboardEvent
    mousedown: \MouseEvent
    mouseenter: \MouseEvent
    mouseleave: \MouseEvent
    mousemove: \MouseEvent
    mouseout: \MouseEvent
    mouseup: \MouseEvent
    resize: \UIEvent
    scroll: \UIEvent
    select: \UIEvent
    storage: \StorageEvent
    submit: \Event
    touchcancel: \TouchEvent
    touchen: \TouchEvent
    touchenter: \TouchEvent
    touchleave: \TouchEvent
    touchmove: \TouchEvent
    touchstart: \TouchEvent
    unload: \UIEvent

  trigger: trigger = (event-name, el) !-->
    # There are two more arguments that we exclude from signature to facilitate
    # currying with optional arguments.
    {TEXT, COMMENT} = helpers.NODE_TYPES

    if el.node-type in [TEXT, COMMENT]
      # Do not handle events on TEXT and COMMENT nodes
      return

    # We fetch data from arguments because currying happens by official
    # signature of the function (i.e., no optional arguments allowed). We still
    # want `data` to be excluded from partial application, so we pretend it's
    # not part of the signature and figure it out later.
    data = arguments.2

    if document.create-event-object?
      e = document.create-event-object!
      e <<< data if data?  # FIXME: this doesn't work on IE8
      el.fire-event "on#{event-name}", e, NOT_CANCELLED
    else
      type = EVENT_TYPES[event-name] or \Event
      e = document.create-event type
      e.init-event event-name, IS_BUBBLING, IS_CANCELABLE
      e <<< data if data?
      el.dispatch-event e

  add-listener: add-listener = (event-name, el, fn) !-->
    if el.attach-event?
      # We first check to see if there's a non-standard `attachEvent` method,
      # and use that if available.
      el.attach-event "on#{event-name}", fn
    else if el.add-event-listener?
      # We use the usual `addEventListener` if that's available.
      el.add-event-listener event-name, fn, NO_CAPTURE
    else
      # As last resort, we use the `onevent` property.
      el["on#{event-name}"] = fn

  remove-listener: remove-listener = (event-name, el, fn) !-->
    if el.detach-event?
      # We first check to see if there's a non-standard `detachEvent` method,
      # and use that first.
      el.detach-event "on#{event-name}", fn
    else if el.remove-event-listener?
      # We use the usual `removeEventListener` if that's available
      el.remove-event-listener event-name, fn, NO_CAPTURE
    else
      el["on#{event-name}"] = null if el["on#{event-name}"] is fn

  evt: evt = (e, default-prevented, no-bubbling) ->
    # Browsers that do not give us the event object will also not give us the
    # `target` property. Instead we must alias the `srcElement` property.
    e.target ?= e.src-element

    # Browsers like IE8 will not have a `preventDefault` method. Instead they
    # expect us to set the `returnValue` property to `false`. We take care of
    # this by adding back the `preventDefault` method ourselves.
    e.prevent-default ?= ->
      @return-value = false

    # Browsers like IE8 also don't support `stopPropagation` method, so we
    # need to patch that in as well.
    e.stop-propagation ?= ->
      @cancel-bubble = true

    # Normalize key codes
    e.which ?= e.key-code
    e.key-code ?= e.which
    e.key-char = String.from-char-code e.which if e.which?

    e.prevent-default! if default-prevented
    e.stop-propagation! if no-bubbling

    e
