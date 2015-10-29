express = require('express')
app = express()
bodyParser = require('body-parser')
Boxy = require('BoxyBrown')


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
      if /\.map$/i.test(file) and !res.headersSent
        res.set('Content-Type', 'application/json')
      return
    )
  )


  app.use(Router)
  
  app.listen(8000)