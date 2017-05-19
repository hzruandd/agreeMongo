//目前搭建了mongodb配置服务器、路由服务器，各个分片服务器，不过应用程序连接到
//mongos 路由服务器并不能使用分片机制，还需要在程序里设置分片配置，让分片生效。

//连接到mongos
/home/rdd/3.2.6-mongo/bin/mongo  127.0.0.1:20000
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
db.runCommand( { shardcollection : "dbname.collectionName", key : {id: 1} } )

//指定库 集合分片
mongos>use admin;
mongos>sh.enableSharding("dbname") 或 db.adminCommand({"enableSharding":"dbname"});
mongos>use dbname;
mongos>db.collectionName.ensureIndex({Date:1});
mongos>use admin;
mongos>sh.shardCollection("dbname.collectionName"，{Date:1});


//验证分片
sh.status();

//查看均衡器
use config;
db.locks.findOne({"_id":"balancer"}).pretty();

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
use config
db.settings.update({"_id":"balancer"},{$set:{activeWindow:{start:"01:00"top:"05:00"}}},true);

//取消时间窗口
use config
db.settings.update({ _id : "balancer" }, { $unset : { activeWindow : true } })

//修改chunk size
//这是一个全局的参数。 默认是64MB。小的chunk会让不同的shard数据量更均衡。 但会导致更多的Migration。
//大的chunk会减少migration。不同的shard数据量不均衡。
//balance一次只会迁移一个chunk。balancer开始行动起来，只有当任意两个shard的chunk数量小于2或者是migration失败才会停止。
db.settings.save( { _id:"chunksize", value: <size> } )

//设置分片上最大的存储容量
//有两种方式，第一种在添加分片时候用maxSize参数指定:
db.runCommand( { addshard : "example.net:34008", maxSize : 125 } )
//第二种方式可以在运行中修改设定：
use config
db.shards.update( { _id : "shard0000" }, { $set : { maxSize : 250 } } )

//http://my.oschina.net/costaxu/blog/196980
