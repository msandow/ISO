Landscape = require('./../Landscape.coffee')

module.exports = class extends Landscape
  constructor: (@x,@y)->
    @type = 'landscape-tree'
    super(@x,@y)
  
  classNameGenerator: ->
    "landscape tree"