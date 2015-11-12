Building = require('./../Building.coffee')

module.exports = class extends Building
  constructor: (@x,@y)->
    @type = 'building-house'
    @width = 2
    @height = 2
    super(@x,@y)
    
    @level = 1


  classNameGenerator: ->
    "building house-#{@level}"
