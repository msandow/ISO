Grid = require('./Grid.coffee')


applyWorldValues = (map)->
  map.world.width = Math.floor(70.7106*map.mapSize)
  map.world.height = Math.floor(42.5496*map.mapSize)
  map.world.offsetLeft = Math.round((10.3432*map.mapSize + 0.451074) + (706.971*map.scale - 706.771))
  map.world.offsetTop = Math.round((-3.72692*map.mapSize - 38.6154) + (422.971*map.scale - 422.771))


setUpWorldSpace = (map)->
  
  map.world.el.style.width = "#{map.world.dimension}px"
  map.world.el.style.height = "#{map.world.dimension}px"
  map.world.el.style.top = "#{map.world.offsetTop}px"
  map.world.el.style.left = "#{map.world.offsetLeft}px"
  map.world.el.style.transform = "rotateX(53deg) rotateZ(45deg) translateZ(-50px) scale(#{map.scale},#{map.scale})"
  
  map


setUpWorldGrid = (map)->
  
  if map.debug
    map.world.el.className = map.world.el.className + " withGrid"
  
  el = document.createElement('div')
  el.className = 'grid-3d'

  map.world.el.appendChild(el)

  y = 1
  e = null
  while y <= map.mapSize    
    x = 1
    while x <= map.mapSize
      e = new Grid(x,y)
      e.spawn().reposition()
      el.appendChild(e.el)      
      x++
    y++



module.exports =
  
  setUp: ->
    applyWorldValues(MAPFILE)
    setUpWorldSpace(MAPFILE)
    window.scrollTo(Math.floor(MAPFILE.world.width/2) - Math.floor(document.body.clientWidth/2), 0)
    setUpWorldGrid(MAPFILE)

    true
  
  update: ->
    applyWorldValues(MAPFILE)
    setUpWorldSpace(MAPFILE)