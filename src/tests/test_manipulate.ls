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

