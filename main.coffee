express = require('express')
app = express()
bodyParser = require('body-parser')
Boxy = require('BoxyBrown')
fs = require('fs')


module.exports = ->

  app.use(bodyParser.urlencoded({ extended: false }))
  app.use(bodyParser.json())  

  Router = new express.Router()

  Router.use(Boxy.CoffeeJs(
    route: '/app.js'
    source: "#{__dirname}/lib/coffee/app.coffee"
    debug: true
  ))
  
  Router.use(Boxy.ScssCss(
    route: '/app.css'
    source: "#{__dirname}/lib/scss/app.scss"
    debug: true
  ))

  Router.use(
    express.static("#{__dirname}/public", setHeaders: (res, file, stats) ->
      res.set({
        'Pragma-directive': 'no-cache'
        'Cache-directive': 'no-cache'
        'Cache-control': 'no-cache'
        'Pragma': 'no-cache'
        'Expires': 0
      })
      
      if /\.map$/i.test(file) and !res.headersSent
        res.set('Content-Type', 'application/json')
      return
    )
  )
  
  Router.get('/resources', (req, res)->
    fs.readdir(__dirname+"/public/images",(err, files)->
      res.send(files.map((i)->
        "images/#{i}"
      ))
    )
  )

  app.use(Router)
  
  app.listen(8000)