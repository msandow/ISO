Tasks = require('./CycleTasks.coffee')
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
    
    Utils.styleElement(MAPFILE.panel.el,{
      marginTop: window.pageYOffset + 'px'
      marginLeft: window.pageXOffset + 'px'
    })
#    evtX = Math.ceil(evt.clientX / MAPFILE.scale)
#    evtY = Math.ceil(evt.clientY / MAPFILE.scale)
#    scrollLeft = Math.ceil(window.pageXOffset / MAPFILE.scale)
#    scrollTop = Math.ceil(window.pageYOffset / MAPFILE.scale)
#    bodyWidth = Math.ceil(document.body.clientWidth / MAPFILE.scale)
#    bodyHeight = Math.ceil(document.body.clientHeight / MAPFILE.scale)
#
#    window.scrollTo(
#      scrollLeft + evtX - Math.floor(bodyWidth/2),
#      scrollTop + evtY - Math.floor(bodyHeight/2)
#    )
  
  false


MOVE_PANEL = ->
  Utils.styleElement(MAPFILE.panel.el,{
    marginTop: window.pageYOffset + 'px'
    marginLeft: window.pageXOffset + 'px'
    top: document.documentElement.clientHeight + 'px'
  })


TOGGLE_FULL_SCREEN = ->
  vendorProp = (vendor, prop)->
    return prop if not vendor.length
    prop = prop.replace('screen', 'Screen') if vendor is 'moz'
    return vendor + prop[0].toUpperCase() + prop.slice(1)
    
  vendor = false
  vendors = ['','ms','moz','webkit']
  for v in vendors
    if document[ vendorProp(v, 'fullscreenElement') ] isnt undefined
      vendor = v
      break
  
  if vendor is false
    alert('No fullscreen support in this browser')
    return

  if !document[ vendorProp(vendor, 'fullscreenElement') ]
    document.documentElement[ vendorProp(vendor, 'requestFullscreen') ]()
  else
    document[ vendorProp(vendor, if vendor is 'moz' then 'cancelFullscreen' else 'exitFullscreen') ]()


DEBUG_WORLD = (evt)->
  if evt.target and evt.target.parentElement and evt.target.parentElement._clz
    console.log(evt.target.parentElement._clz)
  else if evt.target._clz
    console.log(evt.target._clz)
  true


module.exports = ->
  
  Tasks.add(->
    
    if SCROLL_COMMAND.x or SCROLL_COMMAND.y
      
      window.scrollTo(window.pageXOffset + SCROLL_COMMAND.x, window.pageYOffset + SCROLL_COMMAND.y)

      Utils.styleElement(MAPFILE.panel.el,{
        marginTop: window.pageYOffset + 'px'
        marginLeft: window.pageXOffset + 'px'
      })
  )
  
  document.body.addEventListener('mouseout',SCROLL_RESET)
  
  document.addEventListener('mousemove', SCROLL_DETECTION)
  
  document.addEventListener('mousewheel', ZOOM_DETECTION)
  
  document.addEventListener('DOMMouseScroll', ZOOM_DETECTION)
  
  window.addEventListener("resize", MOVE_PANEL)
  
  document.body.addEventListener('click',(evt)->
    DEBUG_WORLD(evt) if MAPFILE.debug and MAPFILE.world.el.contains(evt.target)
    
    TOGGLE_FULL_SCREEN() if Utils.matches(evt.target, '.controlPanel .tab .full')
  )
