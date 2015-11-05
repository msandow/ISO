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