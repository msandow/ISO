global = require('./GLOBAL.coffee')

module.exports = global(
  mapSize: 15
  debug: true
  terrain: Array.apply(null, Array(15*15)).map(->1)
)