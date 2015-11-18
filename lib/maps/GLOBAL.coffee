Utils = require('./../coffee/Utils.coffee')

module.exports = class
  
  constructor: (conf)->
    @cellSize = 50
    @mapSize = 0
    @debug = false
    @members = {}
    @terrain = []
    @storage = {}
    @clock = 30
    @clockMultiplier = 1
    @scale = 1
    @imports = []
    
    for own k,v of conf
      @[k] = v
    
    @importTerrain(@terrain)
    
    @world =
      el: document.querySelector('body > .plane-3d')
      dimension: @mapSize * @cellSize
      width: null
      height: null
      offsetLeft: null
      offsetTop: null
    
    @


  importTerrain: (terr)->
    return @ if terr.every((t)->
      typeof t is 'number'
    )
    
    
    @terrain


  exportTerrain: ()->
    ex = [{
      value: @terrain[0]
      run: 1
    }]
    
    idx = 1
    len = @terrain.length
    point = ex[0]
    while idx < len
      
      if @terrain[idx] is point.value
        
        point.run++
      
      else
      
        ex.push({
          value: @terrain[idx]
          run: 1
        })
        
        point = ex[ ex.length - 1 ]
        
      idx++
    
    ex.map((i)->
      "#{i.run}x#{i.value}"
    )


  addItemToWorld: (item)->
    item.spawn()
    @world.el.appendChild(item.el)
    
    startX = item.x
    startY = item.y
    endX = item.x + item.width
    endY = item.y + item.height
    
    while startY < endY
      startX = item.x
      while startX < endX

        grid = @members.grid[ Utils.XYtoIdx(startX, startY) ]
        grid.data.children.push(item)
        item.data.parents.push(grid)

        startX++

      startY++      
    
    item.restyle()
    
    @


  importMembers: ()->
    for imp in @imports
      @addItemToWorld(imp)
    
    @