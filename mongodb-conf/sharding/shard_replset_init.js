#设置第一个分片副本集
/home/rdd/3.2.6-mongo/bin/mongo  127.0.0.1:22001
#使用admin数据库
use admin
#定义副本集配置
config = { _id:"shard1", members:[
                     {_id:0,host:"10.9.1.199:22001"},
                     {_id:1,host:"10.9.1.197:22001"},
                     {_id:2,host:"10.9.1.195:22001",arbiterOnly:true}
                ]
         }

#初始化副本集配置
rs.initiate(config);


############################shard2#######################
#设置第二个分片副本集
/home/rdd/3.2.6-mongo/bin/mongo  127.0.0.1:22002
#使用admin数据库
use admin
#定义副本集配置
config = { _id:"shard2", members:[
                     {_id:0,host:"10.9.1.199:22002", arbiterOnly:true},
                     {_id:1,host:"10.9.1.197:22002"},
                     {_id:2,host:"10.9.1.195:22002"}
                ]
         }
#初始化副本集配置
rs.initiate(config);

#设置第三个分片副本集
/home/rdd/3.2.6-mongo/bin/mongo    127.0.0.1:22003



############################shard3#######################
#使用admin数据库
use admin

#定义副本集配置
config = { _id:"shard3", members:[
                     {_id:0,host:"10.9.1.199:22003"},
                     {_id:1,host:"10.9.1.197:22003", arbiterOnly:true},
                     {_id:2,host:"10.9.1.195:22003"}
                ]
         }

#初始化副本集配置
rs.initiate(config);
