define = ((root) ->
  if typeof root.define is \function and root.define.amd
    root.define
  else
    require = (dep) -> root.utils
    (factory) ->
      (root.utils ?= {}) <<< factory require
) this

define (require) ->
  helpers = require './helpers'

  remove: remove = (el) !->
    return if not el?
    if el.length
      for e in el
        remove e
    else
      el.parent-node.remove-child el

  css: css = (property, value, el) !-->
    property = helpers.camelize property
    el.style[property] = value if el.style[property]?

  add-class: add-class = (name, el) !-->
    if el.class-list?
      el.class-list.add name
    else
      if el.class-name.length
        el.class-name += " #{name}"
      else
        el.class-name += name

  remove-class: remove-class = (name, el) !-->
    if el.class-list?
      el.class-list.remove name
    else
      el.class-name = el.class-name.replace RegExp " ?#{name}"
