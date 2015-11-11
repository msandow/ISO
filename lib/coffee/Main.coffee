module.exports = ->
  setTimeout(->
    window.MAPFILE = require('./../maps/debug.coffee')

    if !require('./Modern.coffee')()
      alert('No 3D support in this browser')
      return

    require('./RenderWorld.coffee').setUp()
    require('./Events.coffee')()
  
  ,100)