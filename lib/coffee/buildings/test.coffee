Building = require('./../Building.coffee')

module.exports = class extends Building
  constructor: (@x,@y)->
    @type = 'building-buildingTest'
    super(@x,@y)
    
    @structure = """
    <div>
      <div class='front'></div>
      <div class='side'></div>
    </div>
    """
  
  classNameGenerator: ->
    "building test-building"