jobs = []

(do->
  GAME_ENGINE = ()->
    job() for job in jobs
    
    setTimeout(GAME_ENGINE, Math.round(1000 / (MAPFILE.clock * MAPFILE.clockMultiplier)))
  
  GAME_ENGINE()
)

module.exports =
  add: (j)->
    idx = jobs.length
    o = {
      idx: idx
      remove: ()->
        jobs.splice(idx, 1)
    }

    jobs.push(j.bind(null, o))
    
    o