define = ((root) ->
  if typeof root.define is \function and root.define.amd
    root.define
  else
    (factory) ->
      (root.utils ?= {}) <<< factory!
) this

define ->

  by-id: by-id = (->
    cache = {}
    fn = (id) ->
      cache[id] or cache[id] = document.get-element-by-id id
    fn.clear-cache = -> cache := {}
    fn
  )!

  by-class: by-class = (scope, cls) -->
    scope.get-elements-by-class-name? cls or scope.query-selector-all? ".#{cls}"
