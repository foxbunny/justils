define = ((root) ->
  if typeof root.define is \function and root.define.amd
    root.define
  else
    (factory) ->
      (root.utils ?= {}) <<< factory!
) this

define ->

  remove: remove = (el) !->
    return if not el?
    if el.length
      for e in el
        remove e
    else
      el.parent-node.remove-child el
