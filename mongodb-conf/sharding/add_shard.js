//目前搭建了mongodb配置服务器、路由服务器，各个分片服务器，不过应用程序连接到
//mongos 路由服务器并不能使用分片机制，还需要在程序里设置分片配置，让分片生效。

//连接到mongos
/home/rdd/3.2.6-mongo/bin/mongos  127.0.0.1:20000
//使用admin数据库
user  admin
//串联路由服务器与分配副本集1
db.runCommand( { addshard : "shard1/10.9.1.199:22001,10.9.1.197:22001,10.9.1.195:22001"});

//串联路由服务器与分配副本集2
db.runCommand( { addshard : "shard2/10.9.1.199:22002,10.9.1.197:22002,10.9.1.195:22002"});

//串联路由服务器与分配副本集3
db.runCommand( { addshard : "shard3/10.9.1.199:22003,10.9.1.197:22003,10.9.1.195:22003"});

//查看分片服务器的配置
db.runCommand( { listshards : 1 } );



//至此，配置服务、路由服务、分片服务、副本集服务都已经串联起来了，接下来设置需要分片的集合
db.runCommand( { enablesharding :"dbname"});
db.runCommand( { shardcollection : "dbname.table1", key : {id: 1} } )


//验证分片
sh.status();

//查看均衡器
use config;
db.locks.findOne({"_id":"balancer"});

//启动均衡器
use config;
sh.setBalancerState(true);

//关闭均衡器
sh.setBalancerState(false);
or
sh.stopBalancer()
or
use admin;db.settings.update({_id:"balancer"},{$set:{stopped:true}},{upsert:true});

//设置时间窗口
db.settings.update({"_id":"balancer"},{$set:{activeWindow:{start:"01:00"top:"05:00"}}},true);

