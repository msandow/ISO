jobs = []

(do->
  setInterval(->
    
    for job in jobs
      job()
    
  ,MAPFILE.clock)
)

module.exports =
  add: (j)->
    jobs.push(j)