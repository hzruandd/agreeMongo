针对mongodb系统级别的优化：
=====================================

   第一步：
  使用root用户权限登录：

    echo "never" > /sys/kernel/mm/transparent_hugepage/enabled
    echo "never" > /sys/kernel/mm/transparent_hugepage/defrag

   第二步：
   使用root用户权限登录：
    vim /etc/profile

   添加以下命令：

    ulimit -f unlimited
    ulimit -t unlimited
    ulimit -v unlimited
    ulimit -n 64000
    ulimit -m unlimited
    ulimit -u 32000

#############
AND类型查找考虑点
把结果集最小的条件放到最前面，同理把这样的字段索引放到最前面。

OR类型查找考虑点---把结果集最大的条件放到最前面，同理把这样的字段索引放到最后面。
################
单机做日志，多机多复制。如果性能要求不是太高，但是数据安全性却非常重要，那就两个结合起来。
{getLastError: 1, w: num(绝对安全，w就得大于节点数的一半，然而小于半数也是可行滴), wtimeout: 100(ms)}
不要每次写入都调用fsync，sync并不是立即将数据写入磁盘，而是让应用程序暂停直到数据写入磁盘。
大约每次sync耗时100ms。通常fsync只与日志搭配使用。
################
备份用的从属节点可以用日志，活跃节点和热备节点（读取负载均衡的节点）可以不用。
################
不要信任repair恢复数据----不仅数据丢失的继续丢失，还消耗大量磁盘空间。推荐做法：
从备份快速恢复，或者从头开始同步。在同步之前一定要清除所有损坏的数据，因为
MongoDB的复制是不能修复这些损坏数据滴。
################
不要改变复制组成员投票的权值---选举很铁面无私，未必会投自己的票。
################
开发环境可以使用--notablscan选项---如果全表扫描就返回错误，有索引则正常。但是在生产环境就不能使用这个选项了
了，因为在线上常常要做的很多管理任务都要表扫描。
################
#创建启动文件----假如做一些shell维护工作，比如避免删数据库，集合，文档：
//no-delete.js
    delete DBCollection.prototype.drop;
    delete DBCollection.prototype.remove;
    delete DB.prototype.dropDatabase;
    db.test.drop() ///Users/jake/agree db.test.drop() is not a function.

此时还想删除集合，就可以执行db.$cmd.findOne({drop: "test"})
如果连这个都不让执行了，那就把find()也删掉，不过此时shell也就干不了啥了。
