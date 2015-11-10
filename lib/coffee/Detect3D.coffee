webKitify = (str)->
  "webkit" + str[0].toUpperCase() + str.slice(1)

module.exports = ->
  el = document.createElement('div')
  document.body.appendChild(el)
  
  #CSS Tests
  
  test = 
    transformStyle: 'preserve-3d'
    clipPath: "url(\"#{window.location.href}\")"
  
  for own prop, value of test
    el.style[prop] = value
    el.style[webKitify(prop)] = value
  
  supported = true
    
  st = window.getComputedStyle(el, null)
  
  for own prop, value of test
    if /^url\(/i.test(value)
      valuer = [value, value.replace(/"/g, '')]
    else
      valuer = [value]
    
    #console.log(prop, st[prop], webKitify(prop), st[webKitify(prop)], valuer)
    supported = supported and (
      (st[prop] and valuer.indexOf(st[prop]) > -1) or
      (st[webKitify(prop)] and valuer.indexOf(st[webKitify(prop)]) > -1)
    )
  
  document.body.removeChild(el)
  
  supported