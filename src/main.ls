# Justils main package

define = ((root) ->
  if typeof root.define is 'function' and root.define.amd
    return root.define
  else
    return ->
) this

define (require) ->
  require! './helpers'
  require! './traverse'
  require! './manipulate'
  require! './events'
  require! './filter'

  # This object will hold the main package
  justils = {}

  # Import all package modules
  justils <<< helpers
  justils <<< traverse
  justils <<< manipulate
  justils <<< events
  justils <<< filter

  justils
