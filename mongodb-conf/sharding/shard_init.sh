#规划5个组件对应的端口号，由于一个机器需要同时部署 mongos、config server 、shard1、shard2、shard3，所以需要用端口进行区分。
#这个端口可以自由定义，在本文 mongos为 20000， config server 为 21000， shard1为 22001 ， shard2为22002， shard3为22003
#
SERVER_IP1=10.9.1.199
SERVER_IP2=10.9.1.197
SERVER_IP3=10.9.1.195
MONGOS_PORT=21000

set -ex
mkdir -p /home/mongoshard/data/db
mkdir -p /home/mongoshard/log

"""
127,128,129 mongos and mongoconfig;

125,126,140 shard1;

115,116,117 shard2;

118,119,141 shard3;


140,117,141 arbiterOnly;

10.8.6.113,123,124 client;
"""

#create mongos dir
mkdir -p /home/mongoshard/mongos/log

mkdir -p /home/mongoshard/config/data
mkdir -p /home/mongoshard/config/log

mkdir -p /home/mongoshard/shard1/data
mkdir -p /home/mongoshard/shard1/log


mkdir -p /home/mongoshard/shard2/data
mkdir -p /home/mongoshard/shard2/log



mkdir -p /home/mongoshard/shard3/data
mkdir -p /home/mongoshard/shard3/log



##first, start  the config server

cd /home/rdd/3.2.6-mongo
pwd
./bin/mongod --configsvr --dbpath /home/mongoshard/config/data --port 21000 --logpath /home/mongoshard/config/log/config.log --fork


##second, start the mongos server

cd /home/rdd/3.2.6-mongo
pwd

./bin/mongos  --configdb $SERVER_IP1:$MONGOS_PORT,$SERVER_IP2:$MONGOS_PORT, $SERVER_IP3:$MONGOS_PORT \
 --port 20000   --logpath  /home/mongoshard/mongos/log/mongos.log --fork

##thrid, set every shard's replset

cd /home/rdd/3.2.6-mongo
pwd
./bin/mongod --shardsvr --replSet shard1 --port 22001 --dbpath /home/mongoshard/shard1/data \ 
--logpath /home/mongoshard/shard1/log/shard1.log --fork --nojournal  --oplogSize 51200


./bin/mongod --shardsvr --replSet shard2 --port 22002 \
--dbpath /home/mongoshard/shard2/data --logpath /home/mongoshard/shard2/log/shard2.log --fork --nojournal  --oplogSize 51200


./bin/mongod --shardsvr --replSet shard3 --port 22003 \ 
--dbpath /home/mongoshard/shard3/data --logpath /home/mongoshard/shard3/log/shard3.log --fork --nojournal  --oplogSize 51200
