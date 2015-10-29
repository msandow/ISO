module.exports = ->
  map = require('./../maps/debug.coffee')
  
  console.log(map)
  map.world.el.style.width = "#{map.world.dimension}px"
  map.world.el.style.height = "#{map.world.dimension}px"
  map.world.el.style.margin = "#{map.world.offsetTop}px 0px 0px #{map.world.offsetLeft}px"
  
  window.scrollTo(Math.floor(map.world.width/2) - Math.floor(window.screen.width/2), 0)
  
  true