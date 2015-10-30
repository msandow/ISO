Grid = require('./Grid.coffee')

setUpWorldSpace = (map)->
  
  map.world.el.style.width = "#{map.world.dimension}px"
  map.world.el.style.height = "#{map.world.dimension}px"
  map.world.el.style.margin = "#{map.world.offsetTop}px 0px 0px #{map.world.offsetLeft}px"  
  window.scrollTo(Math.floor(map.world.width/2) - Math.floor(document.body.clientWidth/2), 0)
  
  if map.debug
    map.world.el.className = map.world.el.className + " withGrid"
  
  map


setUpWorldGrid = (map)->
  
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



module.exports = ->

  setUpWorldSpace(MAPFILE)
  setUpWorldGrid(MAPFILE)
  
  true