Landscape = require('./../Landscape.coffee')

module.exports = class extends Landscape
  constructor: (@x,@y)->
    @type = 'landscape-bush'
    super(@x,@y)
  
  classNameGenerator: ->
    "landscape bush"