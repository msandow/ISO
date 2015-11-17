Building = require('./../Building.coffee')

module.exports = class extends Building
  constructor: (@x,@y)->
    @type = 'building-road'
    super(@x,@y)
    @data.level = 1


  classNameGenerator: ()->
    c = "building road-#{@data.level}"
    return c if not @data.around
    
    checker = (top=false, right=false, bottom=false, left=false)=>
      @data.around.top is top and @data.around.right is right and @data.around.bottom is bottom and @data.around.left is left
    
    c += " road_vertical" if checker(true, false, true, false)
    c += " road_top_bookend" if checker(false, false, true, false)
    c += " road_singular" if checker()
    c += " road_bottom_bookend" if checker(true, false, false, false)
    c += " road_cross" if checker(true, true, true, true)
    c += " road_horizontal" if checker(false, true, false, true)
    c += " road_right_bookend" if checker(false, false, false, true)
    c += " road_left_bookend" if checker(false, true, false, false)
    
    c += " road_bottom_right" if checker(false, true, true, false)
    c += " road_top_right" if checker(true, true, false, false)
    c += " road_bottom_left" if checker(false, false, true, true)
    c += " road_top_left" if checker(true, false, false, true)
    
    c
