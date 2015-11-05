Member = require('./Member.coffee')

module.exports = class extends Member
  constructor: (@x,@y)->
    @type = 'building' if @type if undefined
    super()