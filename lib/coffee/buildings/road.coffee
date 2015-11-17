Building = require('./../Building.coffee')

module.exports = class extends Building
  constructor: (@x,@y)->
    @type = 'building-road'
    super(@x,@y)
    @data.level = 1


  classNameGenerator: ()->
    console.log(@data.around)
    "building road-#{@data.level}"
