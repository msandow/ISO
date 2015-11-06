global = require('./GLOBAL.coffee')
TERRAIN = require('./TERRAIN.coffee')
Items = require('./../coffee/Items.coffee')

module.exports = new global(
  mapSize: 20
  debug: true
  terrain: do ->
    a = Array.apply(null, Array(20*20)).map(->TERRAIN.GRASS)
    a[145] = TERRAIN.WOODS
    a[146] = TERRAIN.WOODS
    a[147] = TERRAIN.WOODS
    a[148] = TERRAIN.WOODS
    a[165] = TERRAIN.WOODS
    a[166] = TERRAIN.WOODS
    a[167] = TERRAIN.WOODS
    a[168] = TERRAIN.DIRT
    a
  imports: do ->
    a = []
    
    a.push(new Items.building.test(2,2))
    a.push(new Items.landscape.bush(7,8))
    a.push(new Items.landscape.tree(6,9))
    
    a
)