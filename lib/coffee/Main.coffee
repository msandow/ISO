module.exports = ->
  setTimeout(->
    window.MAPFILE = require('./../maps/debug.coffee')
    
    require('./RenderWorld.coffee')()
  
  ,100)