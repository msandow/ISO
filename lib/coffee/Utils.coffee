module.exports =
  XYtoIdx: (x, y)->
    x--
    y--

    (y*MAPFILE.mapSize) + x


  styleElement: (el, styles)->
    for own prop, value of styles
      el.style[prop] = value
    
    el


  stringToDOM: (str)->
    a = document.createElement("div")
    a.innerHTML = str

    a.firstChild


  weightedRandom: (arr)->
    weightSum = arr.reduce((prev, curr)->
      if typeof prev is 'number'
        return prev + curr.weight
      else        
        return prev.weight + curr.weight
    )

    rand = Math.floor(Math.random() * weightSum) + 1

    for item in arr
      if rand <= item.weight
        return item.value
      
      rand -= item.weight

    #console.log(weightSum)