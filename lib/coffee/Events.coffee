Jobs = require('./Jobs.coffee')

module.exports = ->
  #console.log(MAPFILE)
  
  SCROLL_COMMAND =
    x: 0
    y: 0
  
  Jobs.add(->
    
    if SCROLL_COMMAND.x or SCROLL_COMMAND.y
      window.scrollTo(window.pageXOffset + SCROLL_COMMAND.x, window.pageYOffset + SCROLL_COMMAND.y)
  )
  
  document.body.addEventListener('mouseout',()->
    SCROLL_COMMAND.x = 0
    SCROLL_COMMAND.y = 0
  )
  
  document.body.addEventListener('mousemove',(evt)->
    evtX = evt.clientX / MAPFILE.scale
    evtY = evt.clientY / MAPFILE.scale
    
    GUTTER = 30
    SCROLL_COMMAND.x = 0
    SCROLL_COMMAND.y = 0
    scrollLeft = window.pageXOffset
    scrollTop = window.pageYOffset
    bodyWidth = document.body.clientWidth
    bodyHeight = document.body.clientHeight
    #console.log(evtX)
    if evtX < GUTTER and scrollLeft
      SCROLL_COMMAND.x = evtX - GUTTER

    if bodyWidth - evtX < GUTTER and (MAPFILE.world.width > scrollLeft+bodyWidth)
      SCROLL_COMMAND.x = GUTTER - (bodyWidth - evtX)

    if evtY < GUTTER and scrollTop
      SCROLL_COMMAND.y = evtY - GUTTER

    if bodyHeight - evtY < GUTTER and (MAPFILE.world.height > scrollTop+bodyHeight)
      SCROLL_COMMAND.y = GUTTER - (bodyHeight - evtY)
    
    true
  )