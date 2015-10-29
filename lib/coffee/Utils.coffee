module.exports =
  XYtoIdx: (x, y)->
    x--
    y--

    (y*MAPFILE.mapSize) + x