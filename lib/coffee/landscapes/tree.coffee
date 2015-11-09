Landscape = require('./../Landscape.coffee')
Utils = require('./../Utils.coffee')

module.exports = class extends Landscape
  constructor: (@x,@y)->
    @type = 'landscape-tree'
    super(@x,@y)
  
  classNameGenerator: ->
    Utils.weightedRandom([
      {
        value: 'landscape tree'
        weight: 25
      }
      {
        value: 'landscape tree tall'
        weight: 20
      }
      {
        value: 'landscape tree dual'
        weight: 20
      }
    ])