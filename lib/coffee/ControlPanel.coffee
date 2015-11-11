Member = require('./Member.coffee')


module.exports = class extends Member
  constructor: ()->
    @type = 'controlPanel'
    @structure = """
    <div class="controlPanel">
      <div class="tab">
        <div class="full">FS</div>
      </div>
      <div class="mini"></div>
    </div>
    """
    super()
    
    @events =
      resize: @resizeHandler      
      click: @clickHandler
    
    @


  resizeHandler: (evt)=>
    @restyle()
    true


  clickHandler: (evt)=>        
    @toggleFullScreen() if window.MODERN.matches(evt.target, '.controlPanel .tab .full')
    true


  toggleFullScreen: ->
    if !window.MODERN.isFullScreen()
      window.MODERN.requestFullScreen()
    else
      window.MODERN.exitFullScreen()


  restyle: ->
    @el.style.top = document.documentElement.clientHeight + 'px'
    @el.style.marginTop = window.pageYOffset + 'px'
    @el.style.marginLeft = window.pageXOffset + 'px'
    
    @