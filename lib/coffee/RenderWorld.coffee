Grid = require('./Grid.coffee')
Utils = require('./Utils.coffee')
Items = require('./Items.coffee')
ControlPanel = require('./ControlPanel.coffee')
Terrain = require('./../maps/TERRAIN.coffee')


applyWorldValues = ()->
  MAPFILE.world.width = Math.floor(70.7106*MAPFILE.mapSize)
  MAPFILE.world.height = Math.floor(42.5496*MAPFILE.mapSize)
  MAPFILE.world.offsetLeft = Math.round((10.3432*MAPFILE.mapSize + 0.451074) + (706.971*MAPFILE.scale - 706.771))
  MAPFILE.world.offsetTop = Math.round((-3.72692*MAPFILE.mapSize - 38.6154) + (422.971*MAPFILE.scale - 422.771))


setUpWorldSpace = ()->
  
  Utils.styleElement(MAPFILE.world.el,{
    width: MAPFILE.world.dimension + 'px'
    height: MAPFILE.world.dimension + 'px'
    top: MAPFILE.world.offsetTop + 'px'
    left: MAPFILE.world.offsetLeft + 'px'
    transform: "rotateX(53deg) rotateZ(45deg) translateZ(-50px) scale3d(#{MAPFILE.scale},#{MAPFILE.scale},#{MAPFILE.scale})"
  })
  
  Utils.styleElement(document.body,{
    width: MAPFILE.world.width + 'px'
    height: MAPFILE.world.height + 'px'
  });


setUpWorldGrid = ()->
  
  if MAPFILE.debug
    document.body.className = if document.body.className then document.body.className + " withGrid" else "withGrid"
  
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


sprinkle = ->
  weightArr = [
    {
      value: 'grass'
      weight: 0
    }
    {
      value: 'bush'
      weight: 0
    }
    {
      value: 'tree'
      weight: 0
    }
    {
      value: false
      weight: 0
    }
  ]

  for ter, idx in MAPFILE.terrain when !MAPFILE.members.grid[idx].data.children.length
    
    newItem = false

    if ter is Terrain.GRASS

      weightArr[0].weight = 15
      weightArr[1].weight = 7
      weightArr[2].weight = 1
      weightArr[3].weight = 50

      newItem = Utils.weightedRandom(weightArr)

    else if ter is Terrain.WOODS

      weightArr[0].weight = 5
      weightArr[1].weight = 5
      weightArr[2].weight = 15
      weightArr[3].weight = 1

      newItem = Utils.weightedRandom(weightArr)

    if newItem
      c = Utils.IdxToXY(idx)
      newItem = new Items.landscape[ newItem ](c.x, c.y)
      MAPFILE.addItemToWorld(newItem)


module.exports =
  
  setUp: ->
    require('./SVG.coffee')()
    applyWorldValues()
    setUpWorldSpace()
    window.scrollTo(Math.floor(MAPFILE.world.width/2) - Math.floor(document.body.clientWidth/2), 0)
    setUpWorldGrid()
    MAPFILE.importMembers()
    @assignRoadAngles()
    sprinkle()    
    
    CP = new ControlPanel().spawn().restyle()
    document.body.appendChild(CP.el)
    
    true


  update: ->
    applyWorldValues()
    setUpWorldSpace()


  assignRoadAngles: ->
    if MAPFILE.members.road and MAPFILE.members.road.length

      for r in MAPFILE.members.road
        adj = r.getAdjacentPositions().filter((g)->
          g.data.children.filter((c)-> c.type is 'building-road' ).length
        )
        
        pos =
          top: false
          right: false
          bottom: false
          left: false
        
        for a in adj
          pos.top = true if a.y is r.y - 1
          pos.right = true if a.x is r.x + 1
          pos.bottom = true if a.y is r.y + 1
          pos.left = true if a.x is r.x - 1
        
        r.data.around = pos
        r.restyle()