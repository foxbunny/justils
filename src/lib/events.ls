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

  trigger: trigger = (event-name, el, data) -->
    {TEXT, COMMENT} = helpers.NODE_TYPES
    if el.node-type in [TEXT, COMMENT]
      return

    if document.create-event-object?
      # In browsers like IE8, we have to use craete-event-object, and we have
      # to test for this case first because IE8 has a defunct Event
      # constructor, so the constructor-based dispatching code can be fooled
      # into using it without success. The data object is copied into the event
      # object (be careful not to overwrite anything important, since we don't
      # check for that).
      e = document.create-event-object!
      e <<< data
      el.fire-event "on#{event-name}", e
    else
      type = EVENT_TYPES[event-name] or \Event
      e = document.create-event type
      e.init-event event-name, IS_BUBBLING, IS_CANCELABLE
      e <<< data if data?
      el.dispatch-event e
