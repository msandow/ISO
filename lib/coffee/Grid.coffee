Member = require('./Member.coffee')
Utils = require('./Utils.coffee')
Terrain = require('./../maps/TERRAIN.coffee')

terrainIdToClass = (id)->
  switch id
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


module.exports = class extends Member
  constructor: (x, y)->
    @type = 'grid'
    @structure = '<div><div></div></div>'
    super()
    
    @data.children = []
    @x = x
    @y = y
    @width = 1
    @height = 1
    @idx = Utils.XYtoIdx(@x,@y)
    @terrainId = MAPFILE.terrain[ Utils.XYtoIdx(@x, @y) ]


  classNameGenerator: ->
    c = "grid"
    
    if @x is 1
      c += ' left'
    
    c += terrainIdToClass(@terrainId)
    
    # Create terrain transition tiles
    
    adj = @getAdjacentPositions(false).filter((i)=>
      MAPFILE.terrain[i] isnt @terrainId
    )
    
    if adj.length > 1
      toPair = Utils.arrayOccuranceCount(adj.map((i)->
        MAPFILE.terrain[i]
      ))

      p = {
        top: false
        right: false
        bottom: false
        left: false
      }

      for idx in adj
        if idx is @idx-1
          p.left = true
        else if idx is @idx+1
          p.right = true
        else if idx < @idx
          p.top = true
        else
          p.bottom = true
      
      c += ' corner-topleft' if p.top and p.left
      c += ' corner-topright' if p.top and p.right
      c += ' corner-bottomleft' if p.bottom and p.left
      c += ' corner-bottomright' if p.bottom and p.right

      c += ' sub-' + terrainIdToClass(toPair).trim()
    
    c