Member = require('./Member.coffee')
Utils = require('./Utils.coffee')
Terrain = require('./../maps/TERRAIN.coffee')

module.exports = class extends Member
  constructor: (x, y)->
    @type = 'grid'
    super()
    
    @x = x
    @y = y
    @width = 1
    @height = 1


  classNameGenerator: ->
    c = "grid"
    
    if @x is 1
      c += ' left'
    
    c += switch MAPFILE.terrain[ Utils.XYtoIdx(@x, @y) ]
      when Terrain.DIRT then ''
      when Terrain.GRASS then ' grass'
      else ''
    
    c