Landscape = require('./../Landscape.coffee')

module.exports = class extends Landscape
  constructor: (@x,@y)->
    @type = 'landscape-stump'
    super(@x,@y)
  
  classNameGenerator: ->
    "landscape stump"