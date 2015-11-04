jobs = []

(do->
  setInterval(->
    
    for job in jobs
      job()
    
  ,Math.round(1000 / (MAPFILE.clock * MAPFILE.clockMultiplier)))
)

module.exports =
  add: (j)->
    jobs.push(j)