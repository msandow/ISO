Building = require('./../Building.coffee')

module.exports = class extends Building
  constructor: (@x,@y,level=1)->
    @type = 'building-house'
    @width = 2
    @height = 2
    super(@x,@y)
    @data.level = level


  classNameGenerator: ->
    "building house-#{@data.level}"
