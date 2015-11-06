module.exports = ->
  el = document.createElement('div')
  document.body.appendChild(el)
  el.style.transformStyle = 'preserve-3d'
  
  st = window.getComputedStyle(el, null)
  supported = st.transformStyle and st.transformStyle is 'preserve-3d'
  
  document.body.removeChild(el)
  
  supported