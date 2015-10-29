module.exports = ->
  setTimeout(->

    require('./RenderWorld.coffee')()
  
  ,100)