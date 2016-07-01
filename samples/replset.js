rs.initiate({ "_id" : "replset", "members" : 
  [
{ "_id" : 1, "host" : "127.0.0.1:27027"},
{ "_id" : 2, "host" : "127.0.0.1:27028"},
{ "_id" : 3, "host" : "127.0.0.1:27029"},
]
})

db.runCommand({ "replSetInitiate" :
  { "_id" : "replset", 
    "members" : [
  { "_id" : 1, "host" : "127.0.0.1:27027"},
  { "_id" : 2, "host" : "127.0.0.1:27028"},
  { "_id" : 3, "host" : "127.0.0.1:27029"},
  ]
  }
})
