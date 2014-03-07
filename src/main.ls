# Justils main package

define = ((root) ->
  if typeof root.define is 'function' and root.define.amd
    return root.define
  else
    return ->
) this

define (require) ->
  require! './lib/helpers'
  require! './lib/traverse'
  require! './lib/manipulate'
  require! './lib/events'
  require! './lib/filter'

  # This object will hold the main package
  just = {}

  # Import all package modules
  just <<< helpers
  just <<< traverse
  just <<< manipulate
  just <<< events
  just <<< filter

  just
