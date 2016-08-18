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

//有两种方法实现从机的查询：
//第一种方法：db.getMongo().setSlaveOk();
//第二种方法：rs.slaveOk();
//
//
//
//cfg = rs.conf()
//cfg.members[0].priority = 1
//cfg.members[1].priority = 2
//cfg.members[2].priority = 1
//rs.reconfig(cfg)
//
//
//

