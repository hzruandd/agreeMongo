##mongoDB常用统计和故障排查工具

#profile
profiling levels：0,关闭profile；1，只抓取slow查询；2，抓取所有数据。

启动profile并且设置Profile级别：

可以通过mongo shell启动，也可以通过驱动中的profile命令启动，启动后记录会被保存在system.profile
collection下，可以使用db.setProfilingLevel来启动。默认slow为100
毫秒。db.setProfilingLevel可以有2个参数，第一个参数指定Profiling 级别，第二个参
数指定slow阀值。

#检查当前Profiling
级别：可以通过db.getProfilingStatus()获取当前profiling级别，slowms 标记慢查询阀值。

#关闭Profiling
使用db.setProfilingLevel(0)来关闭profiling

整个实例开启Profiling：mongod --prifile=1 --slowms=15

shard的Profiling：对shard的profiling要对每一个实例进行profiling

#查看Profiling数据

 可以直接在system.profile的collection上查看如：db.systen.profile.find()。或者使用show
profile，会显示最近至少1ms时间运行的前5条记录。

#要修改system.profile collection的大
1.关闭profiling
2.删除system.profile
3.然后重新创建system.profile
4.重启profile。

shell如下:db.setProfilingLevel(0)

db.system.profile.drop()

db.createCollect("system.profile",{cappedLtrueize:4000000})

db.setProfilingLevel(1)

#mongostat 

#mongotop

#mongoperf

#ServerStatus 
db.serverStatus()
 
包含了很多信息
1.实例信息

2.锁

3.全局锁

4.内存使用

5.连接

6.额外信息

7.索引计数器

8.cursors

9.网络

10.复制集

11.复制集操作集数

12.操作计数器

13.断言

14.writeBackQueued

15.Journal（dur）持久性

16.recordStats

17.工作集（workingSet）

18.指标(metrics)

#其他工具
db.stats() //数据库所占用的存储
db.collection.stats() //collection的一些统计信息
