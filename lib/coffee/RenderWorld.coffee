Grid = require('./Grid.coffee')
Utils = require('./Utils.coffee')
Items = require('./Items.coffee')


applyWorldValues = ()->
  MAPFILE.world.width = Math.floor(70.7106*MAPFILE.mapSize)
  MAPFILE.world.height = Math.floor(42.5496*MAPFILE.mapSize)
  MAPFILE.world.offsetLeft = Math.round((10.3432*MAPFILE.mapSize + 0.451074) + (706.971*MAPFILE.scale - 706.771))
  MAPFILE.world.offsetTop = Math.round((-3.72692*MAPFILE.mapSize - 38.6154) + (422.971*MAPFILE.scale - 422.771))

  for ter, idx in MAPFILE.terrain when [1,2].indexOf(ter) > -1
    if ter is 1 and 0.35 < Math.random() < 0.65
      c = Utils.IdxToXY(idx)
      MAPFILE.imports.push( new Items.landscape.grass(c.x, c.y) )
    if ter is 2 and 0.1 < Math.random() < 0.9
      c = Utils.IdxToXY(idx)
      MAPFILE.imports.push( new Items.landscape.grass(c.x, c.y) )


setUpWorldSpace = ()->
  Utils.styleElement(MAPFILE.world.el,{
    width: MAPFILE.world.dimension + 'px'
    height: MAPFILE.world.dimension + 'px'
    top: MAPFILE.world.offsetTop + 'px'
    left: MAPFILE.world.offsetLeft + 'px'
    transform: "rotateX(53deg) rotateZ(45deg) translateZ(-50px) scale3d(#{MAPFILE.scale},#{MAPFILE.scale},#{MAPFILE.scale})"
  })


setUpWorldGrid = ()->
  
  #if MAPFILE.debug
  #  MAPFILE.world.el.className = MAPFILE.world.el.className + " withGrid"
  
  el = document.createElement('div')
  el.className = 'grid-3d'

  MAPFILE.world.el.appendChild(el)

  y = 1
  e = null
  while y <= MAPFILE.mapSize    
    x = 1
    while x <= MAPFILE.mapSize
      e = new Grid(x,y)
      e.spawn().restyle()
      el.appendChild(e.el)      
      x++
    y++


module.exports =
  
  setUp: ->
    applyWorldValues()
    setUpWorldSpace()
    window.scrollTo(Math.floor(MAPFILE.world.width/2) - Math.floor(document.body.clientWidth/2), 0)
    setUpWorldGrid()
    MAPFILE.importMembers()
    #@sprinkle()

    true


  update: ->
    applyWorldValues()
    setUpWorldSpace()

  
  sprinkle: ()->
    addGrass = (grid)->
      grass = new Items.landscape.grass(grid.x, grid.y).spawn().restyle()
      MAPFILE.world.el.appendChild(grass.el)
  
    for grid in MAPFILE.members.grid
      if grid.terrainId is 1 and /grass_[1-2]/.test(grid.el.className) and 0.25 < Math.random() < 0.75
        addGrass(grid)
      else if grid.terrainId is 2 and 0.1 < Math.random() < 0.9
        addGrass(grid)