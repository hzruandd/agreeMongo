mongoDB常用操作
================

#查看索引
db.collname.getIndexes()
db.getCollection("collname").getIndexes()

#设置Slave节点可读
db.getMongo().setSlaveOk();

#查看所有用户
use admin

show users
或
db.system.users.find()

#安全关闭MognoDB
千万不要 kill -9 pid，可以 kill -2 pid 或 kill -4 pid 或 db.shutdownServer()

#登陆校验
./bin/mongo -u rdd -p rddtest -host 10.8.6.128 --authenticationDatabase

#添加复制集群
##Replica Set Configuration Document Example
{
  _id: <string>,
  version: <int>,
  protocolVersion: <number>,
  members: [
    {
      _id: <int, 0-255>,
      host: <string>,

      ####rs.addArb() add an arbiter
      arbiterOnly: <boolean>,
      buildIndexes: <boolean>,
      hidden: <boolean>,
      ####Specify higher values to make a member more eligible to become primary, 
      ####and lower values to make the member less eligible.
      priority: <number, 0-100,>,

      tags: <document>,

      ####The number of seconds “behind” the primary that this replica set member should “lag”.
      slaveDelay: <int>,

     ####A replica set can have up to 50 members but only 7 voting members. 
     ####If you need more than 7 members in one replica set, set members[n].votes to 0 
     ####for the additional non-voting members.
      votes: <number, 0-1>
    },
  ],
  settings: {
    chainingAllowed : <boolean>,
    heartbeatIntervalMillis : <int>,
    heartbeatTimeoutSecs: <int>,
    electionTimeoutMillis : <int>,
    getLastErrorModes : <document>,
    getLastErrorDefaults : <document>
  }
}
###此处要注意， _id:”repset” 和上面命令参数“ –replSet repset” 要保持一致。
config = { _id:"repset", members:[
 {_id:0,host:"10.8.6.127:27017"},
 {_id:1,host:"10.8.6.128:27017"},
 {_id:2,host:"10.8.6.129:27017"}]
 }


rs.initiate(config);
rs.status()

###To add a member
[rs.add()](https://docs.mongodb.com/manual/reference/method/rs.add/#rs.add)
[rs.reconfig()](https://docs.mongodb.com/manual/reference/method/rs.reconfig/#rs.reconfig)

#用户管理
##添加管理员
db.createUser(
  {
    user: "rdd",
    pwd: "rddtest",
    roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
  }
)

##添加一个DB的用户
db.createUser(
  {
    user: "rdd",
    pwd: "rddtest",
    roles: [ { role: "readWrite", db: "rdd" } ]
  }
)

##添加只读用户
db.createUser(
  {
    user: "rddreadonly",
    pwd: "rddtest",
    roles: [ { role: "read", db: "rdd" } ]
  }
)



#工具
图形界面比较常用的有robomongo（开源）和mongochef（收费）。mongodb
compass是官方支持的GUI，不过起步时间不长，有兴趣可以去了解下。
