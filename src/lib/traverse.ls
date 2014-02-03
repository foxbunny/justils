define = ((root) ->
  if typeof root.define is \function and root.define.amd
    root.define
  else
    (factory) -> (root.utils ?= {}) <<< factory!
) this

define ->

  by-id: by-id = (->
    cache = {}
    fn = (id, do-cache = true) ->
      if do-cache
        cache[id] or cache[id] = document.get-element-by-id id
      else
        document.get-element-by-id id
    fn.clear-cache = -> cache := {}
    fn
  )!

  by-class: by-class = (cls, el) -->
    if el.get-elements-by-class-name?
      el.get-elements-by-class-name cls
    else
      el.query-selector-all ".#{cls}"

  by-tag: by-tag = (name, el) -->
    el.get-elements-by-tag-name name
