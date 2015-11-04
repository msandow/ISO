module.exports = ->
  setTimeout(->
    window.MAPFILE = require('./../maps/debug.coffee')
    
    require('./RenderWorld.coffee').setUp()
    require('./Events.coffee')()
  
  ,100)