describe 'just.camelize', !-> ``it``

  .. 'should camelCase dash-separted names', !->
    expect just.camelize 'foo-bar' .to-be 'fooBar'

  .. 'should camelCase with more than one dash', !->
    expect just.camelize 'foo-bar-baz' .to-be 'fooBarBaz'

  .. 'should work with underscores', !->
    expect just.camelize 'foo_bar' .to-be 'fooBar'

  .. 'should work with mixed underscore and dash', !->
    expect just.camelize 'foo_bar-baz' .to-be 'fooBarBaz'

