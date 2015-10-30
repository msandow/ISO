module.exports = (conf)->
  ob =
    cellSize:50
    mapSize:0
    debug:false
    members: {}
    terrain: []
  
  for own k,v of conf
    ob[k] = v
  
  ob.clock = Math.round(2000/30)
  
  ob.world =
    el: document.querySelector('body > .plane-3d')
    dimension: ob.mapSize * ob.cellSize
    width: Math.floor(70.7106*ob.mapSize)
    height: Math.floor(42.5496*ob.mapSize)
    offsetLeft: (10.3432*ob.mapSize + 0.451074)
    offsetTop: (-3.72692*ob.mapSize - 38.6154)
    
  
  ob