Building = require('./../Building.coffee')

module.exports = class extends Building
  constructor: (@x,@y)->
    @type = 'building-test'
    super(@x,@y)
  
  classNameGenerator: ->
    "building test-building"