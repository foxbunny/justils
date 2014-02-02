describe 'utils.remove', !-> ``it``

  before-each !->
    set-fixtures """
    <p id="for-removal"></p>
    <div class="for-removal"></div>
    <div class="for-removal"></div>
    <div class="for-removal"></div>
    """

  .. 'should remove an element', !->
    utils.remove utils.by-id \for-removal, false
    expect utils.by-id \for-removal .not.to-exist!

  .. 'should remove an array of elements', !->
    utils.remove utils.by-class \for-removal, document
    el = utils.by-class
    expect el.length .to-equal 0


describe 'utils.css', !-> ``it``

  before-each !->
    set-fixtures """
    <div id="style"></div>
    """

  after-each !->
    utils.by-id.clear-cache!

  .. 'should define styles on element', !->
    el = utils.by-id \style
    utils.css \margin, \2px, el
    expect el.style.margin .to-equal \2px

  .. 'should normalize style names', !->
    el = utils.by-id \style
    utils.css \margin-right, \4px, el
    expect el.style.marginRight .to-equal \4px

  .. 'should not set bogus styles', !->
    el = utils.by-id \style
    utils.css \foo, \bar, el
    expect el.style.foo .not.to-be-defined!

  .. 'should be curried', !->
    el = utils.by-id \style
    padding = utils.css \padding
    hide = utils.css \display, \none
    expect el.style.padding .to-equal ''
    expect el.style.display .to-equal ''
    padding \12px, el
    expect el.style.padding .to-equal \12px
    expect el.style.display .to-equal ''
    hide el
    expect el.style.display .to-equal \none

