Landscape = require('./../Landscape.coffee')

module.exports = class extends Landscape
  constructor: (@x,@y)->
    @type = 'landscape-boulder'
    super(@x,@y)
  
  classNameGenerator: ->
    "landscape boulder"