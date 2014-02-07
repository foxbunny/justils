define = ((root) ->
  if typeof root.define == \function and root.define.amd
    root.define
  else
    (factory) -> (root.just ?= {}) <<< factory!
) this

define ->

  camelize: camelize = (s) ->
    [first, ...rest] = s.split /[-_]/
    first + [r[0].to-upper-case! + r.slice 1 for r in rest].join ''

