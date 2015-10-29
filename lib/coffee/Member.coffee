module.exports = class
  constructor: ->
    @width = 0
    @height = 0
    @x = 0
    @y = 0
    @type = "" if @type is undefined
    @data = {}
    
    @
  
  spawn: ->
    @el = document.createElement('div')
    @el._clz = @
    @el.className = @classNameGenerator()
    
    MAPFILE.members[ @type ] = [] if MAPFILE.members[ @type ] is undefined
    MAPFILE.members[ @type ].push(@)
    
    @

  classNameGenerator: ->
    ""


  reposition: ->
    @el.style.left = (MAPFILE.cellSize * (@x-1)) + 'px'
    @el.style.top = (MAPFILE.cellSize * (@y-1)) + 'px'
    
    @