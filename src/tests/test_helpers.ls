describe 'utils.camelize', !-> ``it``

  .. 'should camelCase dash-separted names', !->
    expect utils.camelize 'foo-bar' .to-be 'fooBar'

  .. 'should camelCase with more than one dash', !->
    expect utils.camelize 'foo-bar-baz' .to-be 'fooBarBaz'

  .. 'should work with underscores', !->
    expect utils.camelize 'foo_bar' .to-be 'fooBar'

  .. 'should work with mixed underscore and dash', !->
    expect utils.camelize 'foo_bar-baz' .to-be 'fooBarBaz'

