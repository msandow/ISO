Landscape = require('./../Landscape.coffee')
Utils = require('./../Utils.coffee')
Terrain = require('./../../maps/TERRAIN.coffee')

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
        weight: if @data.parents.length and @data.parents[0].terrainId is Terrain.WOODS then 20 else 0
      }
    ])