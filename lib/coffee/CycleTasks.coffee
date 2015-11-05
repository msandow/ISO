jobs = []

(do->
  GAME_ENGINE = ()->
    for job in jobs
      job()
    
    setTimeout(GAME_ENGINE, Math.round(1000 / (MAPFILE.clock * MAPFILE.clockMultiplier)))
  
  GAME_ENGINE()
)

module.exports =
  add: (j)->
    jobs.push(j)
    jobs.length-1