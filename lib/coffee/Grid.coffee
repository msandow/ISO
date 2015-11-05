Member = require('./Member.coffee')
Utils = require('./Utils.coffee')
Terrain = require('./../maps/TERRAIN.coffee')

module.exports = class extends Member
  constructor: (x, y)->
    @type = 'grid'
    super()
    
    @data.children = []
    @x = x
    @y = y
    @width = 1
    @height = 1
    @idx = Utils.XYtoIdx(@x,@y)
    @terrain = MAPFILE.terrain[ Utils.XYtoIdx(@x, @y) ]


  classNameGenerator: ->
    c = "grid"
    
    if @x is 1
      c += ' left'
    
    c += switch @terrain
      when Terrain.DIRT then ''
      when Terrain.GRASS
        Utils.weightedRandom([
          {
            value: ' grass_1'
            weight: 50
          }
          {
            value: ' grass_2'
            weight: 25
          }
          {
            value: ' grass_3'
            weight: 25
          }
        ])
      when Terrain.WOODS then ' woods_1'
      else ''
    
    c