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
