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
    GUTTER = 30
    SCROLL_COMMAND.x = 0
    SCROLL_COMMAND.y = 0
    scrollLeft = window.pageXOffset
    scrollTop = window.pageYOffset
    bodyWidth = document.body.clientWidth
    bodyHeight = document.body.clientHeight
    #console.log(evt.clientX)
    if evt.clientX < GUTTER and scrollLeft
      SCROLL_COMMAND.x = evt.clientX - GUTTER

    if bodyWidth - evt.clientX < GUTTER and (MAPFILE.world.width > scrollLeft+bodyWidth)
      SCROLL_COMMAND.x = GUTTER - (bodyWidth - evt.clientX)

    if evt.clientY < GUTTER and scrollTop
      SCROLL_COMMAND.y = evt.clientY - GUTTER

    if bodyHeight - evt.clientY < GUTTER and (MAPFILE.world.height > scrollTop+bodyHeight)
      SCROLL_COMMAND.y = GUTTER - (bodyHeight - evt.clientY)
    
    true
  )