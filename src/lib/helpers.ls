define = ((root) ->
  if typeof root.define == \function and root.define.amd
    root.define
  else
    (factory) -> (root.just ?= {}) <<< factory!
) this

define ->

  NODE_TYPES: NODE_TYPES =
    ELEMENT: 1
    ATTRIBUTE: 2
    TEXT: 3
    CDATA_SECTION: 4
    ENTITY_REFERENCE: 5
    ENTITY: 6
    PROCESSING_INSTRUCTION: 7
    COMMENT: 8
    DOCUMENT: 9
    DOCUMENT_TYPE: 10
    DOCUMENT_FRAGMENT: 11
    NOTATION: 12

  camelize: camelize = (s) ->
    [first, ...rest] = s.split /[-_]/
    first + [r[0].to-upper-case! + r.slice 1 for r in rest].join ''

