Landscape = require('./../Landscape.coffee')
Utils = require('./../Utils.coffee')

module.exports = class extends Landscape
  constructor: (@x,@y)->
    @type = 'landscape-grass'
    super(@x,@y)
  
  classNameGenerator: ->
    Utils.weightedRandom([
      {
        value: 'landscape grass'
        weight: 25
      }
      {
        value: 'landscape grass shift'
        weight: 20
      }
    ])