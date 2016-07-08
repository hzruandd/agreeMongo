#/bin/sh

#系统默认的资源限制，可以很好满足大部分场景的使用，可是当我们提供高并发或者数据库服务的时候，就需要对一些资源限制做一定修改。

"""选项             含义                                                 例子
-H  设置硬资源限制，一旦设置不能增加。          ulimit – Hs 64；限制硬资源，线程栈大小为 64K。
-S  设置软资源限制，设置后可以增加，但是不能超过硬资源设置。    ulimit – Sn 32；限制软资源，32 个文件描述符。
-a  显示当前所有的 limit 信息。                 ulimit – a；显示当前所有的 limit 信息。
-c  最大的 core 文件的大小， 以 blocks 为单位。 ulimit – c unlimited； 对生成的 core 文件的大小不进行限制。
-d  进程最大的数据段的大小，以 Kbytes 为单位。  ulimit -d unlimited；对进程的数据段大小不进行限制。
-f  进程可以创建文件的最大值，以 blocks 为单位。ulimit – f 2048；限制进程可以创建的最大文件大小为 2048 blocks。
-l  最大可加锁内存大小，以 Kbytes 为单位。      ulimit – l 32；限制最大可加锁内存大小为 32 Kbytes。
-m  最大内存大小，以 Kbytes 为单位。            ulimit – m unlimited；对最大内存不进行限制。
-n  可以打开最大文件描述符的数量。              ulimit – n 128；限制最大可以使用 128 个文件描述符。
-p  管道缓冲区的大小，以 Kbytes 为单位。        ulimit – p 512；限制管道缓冲区的大小为 512 Kbytes。
-s  线程栈大小，以 Kbytes 为单位。              ulimit – s 512；限制线程栈的大小为 512 Kbytes。
-t  最大的 CPU 占用时间，以秒为单位。           ulimit – t unlimited；对最大的 CPU 占用时间不进行限制。
-u  用户最大可用的进程数。                      ulimit – u 64；限制用户最多可以使用 64 个进程。
-v  进程最大可用的虚拟内存，以 Kbytes 为单位。  ulimit – v 200000；限制最大可用的虚拟内存为 200000 Kbytes。
"""
"""
题外话：
    首先需要知道ulimit对资源限制是有工作范围的。那么，它限制的对象是单个用户，单个进程，还是整个系统呢？事实上，ulimit 限制的是当前 shell 进程以及其派生的子进程。如果用户同时运行了两个 shell 终端进程，只在其中一个环境中执行了 ulimit – s 100，则该 shell 进程里创建文件的大小收到相应的限制，而同时另一个 shell 终端包括其上运行的子程序都不会受其影响。

    接下来我们该如何做到对一个用户的资源限制呢？通过修改系统的 /etc/security/limits 配置文件。该文件不仅能限制指定用户的资源使用，还能限制指定组的资源使用。该文件的每一行都是对限定的一个描述，格式如下：
 <domain> <type> <item> <value>
    domain 表示用户或者组的名字，还可以使用 * 作为通配符。Type 可以有两个值，soft 和 hard。Item 则表示需要限定的资源，可以有很多候选值，如 stack，cpu，nofile 等等。

    最后可以通过修改 /proc 下的配置文件，做到对整个系统的资源使用做一个总的限制。如/proc/sys/kernel/pid_max等


"""

return-limits(){

     for process in $@; do
          process_pids=`ps -C $process -o pid --no-headers | cut -d " " -f 2`

          if [ -z $@ ]; then
             echo "[no $process running]"
          else
             for pid in $process_pids; do
                   echo "[$process #$pid -- limits]"
                   cat /proc/$pid/limits
             done
          fi

     done


return-limits mongod
return-limits mongos
return-limits mongod mongos
