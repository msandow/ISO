Member = require('./Member.coffee')

module.exports = class extends Member
  constructor: (@x,@y)->
    @type = 'landscape' if @type if undefined
    super()
    @parent = null