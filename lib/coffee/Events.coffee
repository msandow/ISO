Jobs = require('./Jobs.coffee')
Render = require('./RenderWorld.coffee')


SCROLL_COMMAND =
    x: 0
    y: 0


SCROLL_RESET = ()->
  SCROLL_COMMAND.x = 0
  SCROLL_COMMAND.y = 0


SCROLL_DETECTION = (evt)->
  evtX = Math.ceil(evt.clientX / MAPFILE.scale)
  evtY = Math.ceil(evt.clientY / MAPFILE.scale)
  
  GUTTER = 30
  SCROLL_COMMAND.x = 0
  SCROLL_COMMAND.y = 0
  scrollLeft = window.pageXOffset
  scrollTop = window.pageYOffset
  bodyWidth = Math.ceil(document.body.clientWidth / MAPFILE.scale)
  bodyHeight = Math.ceil(document.body.clientHeight / MAPFILE.scale)
  console.log(evt.clientY)
  if evtX < GUTTER and scrollLeft
    SCROLL_COMMAND.x = evtX - GUTTER

  if bodyWidth - evtX < GUTTER and (MAPFILE.world.width > scrollLeft+bodyWidth)
    SCROLL_COMMAND.x = GUTTER - (bodyWidth - evtX)

  if evtY < GUTTER and scrollTop
    SCROLL_COMMAND.y = evtY - GUTTER

  if bodyHeight - evtY < GUTTER and (MAPFILE.world.height > scrollTop+bodyHeight)
    SCROLL_COMMAND.y = GUTTER - (bodyHeight - evtY)

  true


ZOOM_DETECTION = (evt)->
  evt.preventDefault()
  
  delta = Math.max(-1, Math.min(1, (evt.wheelDelta || -evt.detail)))
  
  if delta > 0 and MAPFILE.scale < 2
    MAPFILE.scale += 0.1
    Render.update()
  else if delta < 0 and MAPFILE.scale > 1
    MAPFILE.scale -= 0.1
    Render.update()

  
  false

module.exports = ->
  
  Jobs.add(->
    
    if SCROLL_COMMAND.x or SCROLL_COMMAND.y
      window.scrollTo(window.pageXOffset + SCROLL_COMMAND.x, window.pageYOffset + SCROLL_COMMAND.y)
  )
  
  document.body.addEventListener('mouseout',SCROLL_RESET)
  
  document.addEventListener('mousemove', SCROLL_DETECTION)
  
  document.addEventListener('mousewheel', ZOOM_DETECTION)
  
  document.addEventListener('DOMMouseScroll', ZOOM_DETECTION)