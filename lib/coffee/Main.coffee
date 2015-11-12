module.exports = ->
  setTimeout(->
    window.MAPFILE = require('./../maps/debug.coffee')

    if !require('./Modern.coffee')()
      alert('No 3D support in this browser')
      return
    
    Utils = require('./Utils.coffee')
    
    Done = ->
      require('./RenderWorld.coffee').setUp()
      require('./Events.coffee')()
    
    Utils.ajax('GET','/resources',{},(text, xhr)->
      return alert("Network error. Please refresh.") if xhr.status isnt 200
      files = JSON.parse(text)
      total = files.length
      
      return Done() if not total
      
      checker = (img)->
        ->
          document.body.removeChild(img)
          total--
          Done() if not total
      
      for src in files
        
        img = document.createElement('img')
        img.style.display = 'none'
        img.addEventListener("error",checker(img))
        img.addEventListener("load",checker(img))
        document.body.appendChild(img)
        img.setAttribute("src", src)
    )
    
    
  
  ,100)