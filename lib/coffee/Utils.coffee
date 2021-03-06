module.exports =
  XYtoIdx: (x, y)->
    x--
    y--

    (y*MAPFILE.mapSize) + x


  IdxToXY: (idx)->
    y = Math.floor(idx/MAPFILE.mapSize)+1
    x = (idx - ((y-1)*MAPFILE.mapSize)) + 1
    {x: x, y: y}


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


  arrayOccuranceCount: (arr)->
    o = {}
    
    for item in arr when ['number','string'].indexOf(typeof item) > -1
      if o[item] is undefined
        o[item] = 1
      else
        o[item]++
    
    highest = 0
    point = undefined

    for own k, c of o when c > highest
      highest = c
      point = k
    
    return if /[\D]/.test(point) then point else parseInt(point)


  ajax: (type, url, data, cb=(->))->
    x = new window.MODERN.ajaxClient('MSXML2.XMLHTTP.3.0')
    x.open(type.toUpperCase(), url, 1)
    x.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
    x.setRequestHeader('Content-type', 'application/json;charset=UTF-8');
    
    x.onreadystatechange = ->
      cb(x.responseText, x) if x.readyState is 4
    
    x.send(JSON.stringify(data))
  