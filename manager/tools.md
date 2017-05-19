# 主要介绍 MongoDB 官方的命令行工具

## Mongo shell

MongoDB 的命令行管理工具，也是 MongoDB 最常用的工具，功能非常丰富，比如常用的

show dbs / show tables / show users …

db.stats() 查看 db 的元数据信息

db.colleciont.stats() 查看集合的元数据信息

db.serverStatus() 查看数据库状态信息

rs.conf() 查看复制集的配置信息

rs.status() 查看复制集的状态信息

rs.reconfig() 更改复制集的配置

db.printSlaveReplicationInfo() 查看主备同步延时

db.runCommand() 执行命令

值得一提的是，Mongo shell 还能直接执行js 脚本，对于单个语句没法完成的操作，可以写个简单的 js 脚本，然后通过 mongo shell 来调用，这个功能对于日常的管理、分析等非常方便。

    mongo --host localhost:27017 do_something.js

## mongostat

mongostat 也是很常用的工具，能查看MongoDB 实时的增删改查操作的 pqs、以及内存使用、网络吞吐的信息。

如果使用的是MongoDB 3.2的最新版本，dirty持续超过20 或者 used 持续超过95，说明实例的访问已经超负荷了，可能 cpu 或 IO 资源已经不够用了，需要重点关注下。

## mongotop

mongotop 能实时查看 MongoDB 在哪些集合上花的读写时间最多，能快速找出实例里的热点集合。

## mongoimport/mongoexport

mongoexport 支持以 JSON 或者 CSV 的格式导出 MongoDB 存储的数据，然后使用 mongoimport 将其导入到其他的实例；mongoexport 支持导出单个集合的数据，并能指定查询条件来导出部分符合条件的数据。

    mongoexport --db sales --collection contacts --query '{"field": 1}'

## mongodump/mongorestore

mongodump 与 mongoexport 类似，可用于导出 MongoDB 的数据，不同的时，mongodump 导出的数据以 BSON 的格式存储（BSON 格式数据可以通过 bsondump 工具来转换为 json），存储空间占用上比 JSON、CSV 更小，另外，mongodump 还支持对导出的数据进行压缩、归档，所以如果要对 MongoDB 的数据进行定期备份，推荐使用 mongodump 或 直接进行物理文件备份。

    mongodump --archive=test.20150715.gz --gzip --db test


## mongooplog

mongooplog 可以用于2个独立的 MongoDB 实例间的数据同步，它会不断的从源实例拉取 oplog（tailable cursor），然后重放到目标实例。

    mongooplog  --from mongodb0.example.net --host mongodb1.example.net

## mongofiles

mongofiles 是 gridfs 的命令行客户端，用于向 MongoDB 存储、读取文件，mongofiles 支持put、get、list等接口。

    $mongofiles --host localhost:27017 put hello
    $mongofiles --host localhost:27017 get hello

## mongosniff

mongosniff 是 MongoDB 的抓包工具，直接下载二进制包可能并不包含这个工具，需要下载源码编译出来，mongosniff 可以抓取某个 MongoDB 实例的所有请求及应答数据，对于 MongoDB driver 的开发者非常有帮助，也可以用于一些网络问题的定位。

    $sudo mongosniff --source NET bond0 27017 | head -n 10


