module.exports = (conf)->
  ob =
    cellSize:50
    mapSize:0
    debug:false
    members: {}
    terrain: []

  for own k,v of conf
    ob[k] = v

  ob.clock = 30
  ob.clockMultiplier = 1
  ob.scale = 1

  ob.world =
    el: document.querySelector('body > .plane-3d')
    dimension: ob.mapSize * ob.cellSize
    width: null
    height: null
    offsetLeft: null
    offsetTop: null
    
  
  ob