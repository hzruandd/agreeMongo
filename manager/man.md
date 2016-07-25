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



#工具
图形界面比较常用的有robomongo（开源）和mongochef（收费）。mongodb
compass是官方支持的GUI，不过起步时间不长，有兴趣可以去了解下。
