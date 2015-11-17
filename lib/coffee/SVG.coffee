rand = (n, x)->
  (Math.random() * (x - n) + n)


midpoint = (a, b)->
  {
    x: (a.x+b.x)/2
    y: (a.y+b.y)/2
  }


modifier = ()->
  parseFloat(rand(0,0.15).toPrecision(2))-0.075


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
    
    road_top_bookend: ".5 .2, .65 .3, .8 .5, .8 1, .2 1, .2 .5, .35 .3"
    road_bottom_bookend: ".5 .8, .65 .7, .8 .5, .8 0, .2 0, .2 .5, .35 .7"
    road_vertical: ".2 0, .8 0, .8 .5, .8 1, .2 1, .2 .5"
    road_cross: ".2 0, .8 0, .8 .2, 1 .2, 1 .8, .8 .8, .8 1, .2 1, .2 .8, 0 .8, 0 .2, .2 .2"
    road_horizontal: "0 .2, .5 .2, 1 .2, 1 .8, .5 .8, 0 .8"
    road_right_bookend: ".8 .5, .7 .65, .5 .8, 0 .8, 0 .2, .5 .2, .7 .35"
    road_left_bookend: ".2 .5, .3 .65, .5 .8, 1 .8, 1 .2, .5 .2, .3 .35"
    road_bottom_right: ".2 .2, 1 .2, 1 .8, .8 .8, .8 1, .2 1"
    road_top_right: ".2 0, .8 0, .8 .2, 1 .2, 1 .8, .2 .8"
    road_bottom_left: "0 .2, .8 .2, .8 1, .2 1, .2 .8, 0 .8"
    road_top_left: ".2 0, .8 0, .8 .8, 0 .8, 0 .2, .2 .2"
  
  for own id, path of paths when path
    clip = document.createElementNS(svgNS, 'clipPath')
    clip.setAttributeNS(null,"id",id)
    clip.setAttributeNS(null,"clipPathUnits","objectBoundingBox")
    poly = document.createElementNS(svgNS, 'polygon')
    poly.setAttributeNS(null,"points",fuzzify(path))
    clip.appendChild(poly)
    defs.appendChild(clip)

  
  svg.appendChild(defs)
  document.body.insertBefore(svg, document.body.firstChild)