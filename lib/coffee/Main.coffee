module.exports = ->
  setTimeout(->
    window.MAPFILE = require('./../maps/debug.coffee')
    
    require('./RenderWorld.coffee')()
    require('./Events.coffee')()
  
  ,100)