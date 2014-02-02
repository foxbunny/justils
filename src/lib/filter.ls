define = ((root) ->
  if typeof root.define is \function and root.define.amd
    root.define
  else
    (factory) -> (root.utils ?= {}) <<< factory -> root.utils
) this

define (require) ->
  manipulate = require './manipulate'

  match-class: match-class = (name, el) -->
    return void if not el?
    el if manipulate.has-class name, el

  match-attr: match-attr = (name, val, el) -->
    return void if not el?
    el if (manipulate.attr name, el) is val

  match-selector: match-selector = (selector, el) -->
    return void if not el?

    # Code adapted from http://youmightnotneedjquery.com/#matches_selector

    _matches = el.matches or
      el.matches-selector or
      el.ms-matches-selector or
      el.moz-matches-selector or
      el.webkit-matches-selector or
      el.o-matches-selector

    if _matches?
      el if _matches.call el, selector
    else
      for node in el.parent-node.query-selector-all selector
        return el if node == el
      void

  match-all: match-all = ([first, ...rest], el) -->
    return void if not el?
    return el if not first?
    match-all rest, first el

  filter: filter = (matchers, elements) -->
    return void if not matchers?.length or not elements?.length
    for el in elements
      el if match-all matchers, el
