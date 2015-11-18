Landscape = require('./../Landscape.coffee')
Utils = require('./../Utils.coffee')

module.exports = class extends Landscape
  constructor: (@x,@y)->
    @type = 'landscape-bush'
    super(@x,@y)
  
  classNameGenerator: ->
    Utils.weightedRandom([
      {
        value: 'landscape bush'
        weight: 25
      }
      {
        value: 'landscape bush shift'
        weight: 20
      }
    ])