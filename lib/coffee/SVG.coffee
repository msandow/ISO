rand = (n, x)->
  (Math.random() * (x - n) + n)


midpoint = (a, b)->
  {
    x: (a.x+b.x)/2
    y: (a.y+b.y)/2
  }


modifier = ()->
  parseFloat(rand(0,0.3).toPrecision(2))-0.15


fuzzify = (str)->
  arr = str.split(",").map((i)->
    a = i.trim().split(" ")
    {x: parseFloat(a[0]), y: parseFloat(a[1])}
  )
  
  idx = 0
  while idx < arr.length and arr[idx + 1]
    arr.splice(idx+1, 0, midpoint(arr[idx], arr[idx + 1]))
    idx += 2
  
  arr.push(midpoint(arr[ arr.length-1 ], arr[0]))
  
  for p in arr when p.x isnt 0 and p.x isnt 1 and p.y isnt 0 and p.y isnt 1
    x = p.x + modifier()
    while x <= 0 or x >= 1
      x = p.x + modifier()
    
    p.x = x
    
    y = p.y + modifier()
    while y <= 0 or y >= 1
      y = p.y + modifier()
    
    p.y = y
  
  arr.map((i)->
    "#{i.x} #{i.y}"
  ).join(', ')


module.exports = ->
  svgNS = "http://www.w3.org/2000/svg"
  svg = document.createElementNS(svgNS, 'svg')
  defs = document.createElementNS(svgNS, 'defs')
  
  paths =
    all_corners: ".5 0, .8 .1, 1 .35, 1 .7, .8 .9, .5 1, .2 .9, 0 .7, 0 .35, .2 .1"
    right_corners: ".5 0, .8 .1, 1 .35, 1 .7, .8 .9, .5 1, 0 1, 0 0"
    top_corners: ".5 0, .8 .1, 1 .35, 1 .7, 1 1, 0 1, 0 .7, 0 .35, .2 .1"
    left_corners: ".5 0, 1 0, 1 1,.5 1, .2 .9, 0 .7, 0 .35, .2 .1"
    bottom_corners: "0 0, 1 0, 1 .7, .8 .9, .5 1, .2 .9, 0 .7, 0 .35"
    bottom_right_corner: "0 0, 1 0, 1 .35, 1 .7, .8 .9, .5 1, 0 1"
    bottom_left_corner: "0 0, 1 0, 1 1, .5 1, .2 .9, 0 .7, 0 0"
    top_left_corner: ".5 0, 1 0, 1 1, 0 1, 0 .7, 0 .35, .2 .1"
    top_right_corner: ".5 0, .8 .1, 1 .35, 1 1, 0 1, 0 0"
  
  for own id, path of paths
    clip = document.createElementNS(svgNS, 'clipPath')
    clip.setAttributeNS(null,"id",id)
    clip.setAttributeNS(null,"clipPathUnits","objectBoundingBox")
    poly = document.createElementNS(svgNS, 'polygon')
    poly.setAttributeNS(null,"points",fuzzify(path))
    clip.appendChild(poly)
    defs.appendChild(clip)

  
  svg.appendChild(defs)
  document.body.insertBefore(svg, document.body.firstChild)