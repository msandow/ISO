vendorify = (str, vendor='webkit')->
  vendor + str[0].toUpperCase() + str.slice(1)


supportedCSSFeatures = ->
  el = document.createElement('div')
  document.body.appendChild(el)
    
  test = 
    transformStyle: 'preserve-3d'
    clipPath: "url(\"#{window.location.href}\")"
  
  for own prop, value of test
    el.style[prop] = value
    el.style[vendorify(prop)] = value
  
  supported = true
    
  st = window.getComputedStyle(el, null)
  
  for own prop, value of test
    if /^url\(/i.test(value)
      valuer = [value, value.replace(/"/g, '')]
    else
      valuer = [value]
    
    supported = supported and (
      (st[prop] and valuer.indexOf(st[prop]) > -1) or
      (st[vendorify(prop)] and valuer.indexOf(st[vendorify(prop)]) > -1)
    )
  
  document.body.removeChild(el)
  
  supported


normalize = ->
  d = document
  de = d.documentElement
  
  window.MODERN = {} if window.MODERN is undefined
  
  window.MODERN.isFullScreen = ->
    resp = false
    for m in ['fullscreenElement', 'mozFullScreenElement', 'webkitFullscreenElement', 'msFullscreenElement']
      if d[m]
        resp = d[m]
        break      
    resp
  
  window.MODERN.requestFullScreen = ->
    for m in ['requestFullscreen', 'msRequestFullscreen', 'mozRequestFullScreen', 'webkitRequestFullscreen']
      if de[m]
        de[m]()
        break
  
  window.MODERN.exitFullScreen = ->
    for m in ['exitFullscreen', 'msExitFullscreen', 'mozCancelFullScreen', 'webkitExitFullscreen']
      if d[m]
        d[m]()
        break
  
  window.MODERN.matches = (el, selector) ->
    method = el.matches or el.msMatchesSelector or el.mozMatchesSelector or el.webkitMatchesSelector or el.oMatchesSelector or false
    if method then method.apply(el, [selector]) else false

  window.MODERN.mouseWheelEvent = if document.onmousewheel isnt undefined then 'mousewheel' else 'DOMMouseScroll'
  
  window.MODERN.ajaxClient = if XMLHttpRequest then XMLHttpRequest else ActiveXObject

module.exports = ->
  normalize()
  supportedCSSFeatures()