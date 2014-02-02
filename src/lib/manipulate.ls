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
    if typeof! name is \Array
      name = name.join ' '
    if el.class-name.length
      el.class-name += " #{name}"
    else
      el.class-name += name

  remove-class: remove-class = (name, el) !-->
    if typeof! name is \String
      name = name.split ' '
    if name.length > 1
      re = RegExp " ?(#{name.join \|})", 'g'
    else
      re = RegExp " ?#{name}", 'g'
    el.class-name = el.class-name.replace re, ''

  has-class: has-class = (name, el) -->
    (" #{el.class-name} ".index-of " #{name} ") > -1

  data: data = (name, el) -->
    el.dataset?[name] or el.get-attribute "data-#{name}"

  set-data: set-data = (name, el, value) -->
    if \dataset of el
      el.dataset[name] = value
    else
      el.set-attribute "data-#{name}", value
