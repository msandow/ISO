Cycles = require('./Cycles.coffee')
Render = require('./RenderWorld.coffee')
Utils = require('./Utils.coffee')


SCROLL_COMMAND =
    x: 0
    y: 0


SCROLL_RESET = ()->
  SCROLL_COMMAND.x = 0
  SCROLL_COMMAND.y = 0


SCROLL_DETECTION = (evt)->
  evtX = Math.ceil(evt.clientX / MAPFILE.scale)
  evtY = Math.ceil(evt.clientY / MAPFILE.scale)
  
  GUTTERS = 
    top: 10
    bottom: 10
    left: 10
    right: 10
  
  SCROLL_COMMAND.x = 0
  SCROLL_COMMAND.y = 0
  scrollLeft = Math.ceil(window.pageXOffset / MAPFILE.scale)
  scrollTop = Math.ceil(window.pageYOffset / MAPFILE.scale)
  bodyWidth = Math.ceil(document.documentElement.clientWidth / MAPFILE.scale)
  bodyHeight = Math.ceil(document.documentElement.clientHeight / MAPFILE.scale)

  if evtX < GUTTERS.left and scrollLeft
    SCROLL_COMMAND.x = -30
  
  if bodyWidth - evtX < GUTTERS.right and (MAPFILE.world.width > scrollLeft+bodyWidth)
    SCROLL_COMMAND.x = 30

  if evtY < GUTTERS.top and scrollTop
    SCROLL_COMMAND.y = -30

  if bodyHeight - evtY < GUTTERS.bottom and (MAPFILE.world.height > scrollTop+bodyHeight)
    SCROLL_COMMAND.y = 30

  true


ZOOM_DETECTION = (evt)->
  evt.preventDefault()

  delta = Math.max(-1, Math.min(1, (evt.wheelDelta || -evt.detail)))
  scaleChange = false
  
  if delta > 0 and MAPFILE.scale < 2
    MAPFILE.scale += 0.1
    scaleChange = true
  else if delta < 0 and MAPFILE.scale > 1
    MAPFILE.scale -= 0.1
    scaleChange = true
  
  if scaleChange
    Render.update()
  
  false


DELEGATE_EVENT = (key, evt, global = false)->
  if global
    for own type, arr of MAPFILE.members
      for mem in arr when typeof mem.events[key] is 'function'
        mem.events[key](evt)
  else
    tar = evt.target
    found = false

    while tar.parentNode and !found
      found = tar._clz if tar._clz
      tar = tar.parentNode

    if found and typeof found.events[key] is 'function'
      found.events[key](evt)


module.exports = ->

  Cycles.add((jobId)->    
    if SCROLL_COMMAND.x or SCROLL_COMMAND.y 
      targetX = Math.min(window.pageXOffset + SCROLL_COMMAND.x, MAPFILE.world.width*MAPFILE.scale - document.documentElement.clientWidth)
      targetY = Math.min(window.pageYOffset + SCROLL_COMMAND.y, MAPFILE.world.height*MAPFILE.scale - document.documentElement.clientHeight)
      
      targetY = Math.max(targetY, 0)
      targetX = Math.max(targetX, 0)
      
      if targetX isnt window.pageXOffset or targetY isnt window.pageYOffset
        window.scrollTo(targetX, targetY)      
        MAPFILE.members.controlPanel[0].restyle()
  )
  
  document.addEventListener('mouseout', (evt)->
    SCROLL_RESET() if evt.target is document.body
    DELEGATE_EVENT('mouseout', evt)
  )
  
  document.addEventListener('mousemove', (evt)->
    #SCROLL_DETECTION(evt)
    DELEGATE_EVENT('mousemove', evt)
  )
  
  document.addEventListener(window.MODERN.mouseWheelEvent, (evt)->
    ZOOM_DETECTION(evt)
    DELEGATE_EVENT('mousewheel', evt, true)
  )
  
  window.addEventListener("resize", (evt)->
    DELEGATE_EVENT('resize', evt, true)
  )
  
  document.body.addEventListener('click',(evt)->
    DELEGATE_EVENT('click', evt)
  )
