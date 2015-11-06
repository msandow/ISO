Utils = require('./Utils.coffee')


module.exports = class
  constructor: ->
    @width = 0 if @width is undefined
    @height = 0 if @height is undefined
    @x = 1 if @x is undefined
    @y = 1 if @y is undefined
    @type = "" if @type is undefined
    @data = {} if @data is undefined
    @structure = '<div></div>' if @structure is undefined
    
    @
  
  spawn: ->
    @el = Utils.stringToDOM(@structure)
    @el._clz = @
    
    for type in @type.split('-')
      MAPFILE.members[ type ] = [] if MAPFILE.members[ type ] is undefined
      MAPFILE.members[ type ].push(@)
    
    @

  classNameGenerator: ->
    ""


  restyle: ->
    @el.className = @classNameGenerator()
    @el.style.left = (MAPFILE.cellSize * (@x-1)) + 'px'
    @el.style.top = (MAPFILE.cellSize * (@y-1)) + 'px'
    
    @


  getAdjacentPositions: (asGrids = true)->
    adj = []

    #tops
    i = 0
    ref =
      x: @x
      y: @y
    while i < @width
      if (ref.y-1) >= 1
        adj.push([ ref.x+i, ref.y-1 ])
      i++

    #rights
    i = 0
    ref =
      x: @x + @width-1
      y: @y
    while i < @height
      if (ref.x+1) <= MAPFILE.mapSize
        adj.push([ ref.x+1, ref.y+i ])        
      i++

    #bottoms
    i = 0
    ref =
      x: @x
      y: @y + @height-1
    while i < @width
      if (ref.y+1) <= MAPFILE.mapSize
        adj.push([ ref.x+i, ref.y+1 ])
      i++

    #left
    i = 0
    ref =
      x: @x
      y: @y
    while i < @height
      if (ref.x-1) >= 1
        adj.push([ ref.x-1, ref.y+i ])        
      i++

    adj.map((i)->
      if asGrids
        return MAPFILE.members.grid[ Utils.XYtoIdx(i[0], i[1]) ]
      
      return Utils.XYtoIdx(i[0], i[1])
    )