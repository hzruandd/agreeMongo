netstat 常用命令


  $sudo netstat -antp|grep 8080   查找占用8080端口的程序   这个最常用
  $sudo netstat -np|grep java|wc -l  查看java的并发数
  
  查看80端口请求数最高的20个ip (查找攻击源)
  $netstat -anlp|grep 80|grep tcp|awk '{print $5}'|awk -F: '{print $1}'|sort|uniq -c|sort -nr|head -n20
    
  查看tcp端口的状态
  $netstat -nat |awk '{print $6}'|sort|uniq -c|sort -rn   


参数汇总

   
  -a  show both listening and none-listening sockets.默认是不显示listening sockets
  -t  仅显示tcp相关  默认是都显示
  -u  仅显示udp相关  默认是都显示
  -n  拒绝显示别名，显示数字
  -l  仅列出有在Listen(监听)的服务状态
  -p  显示建立相关连接的程序名   需要sudo才能看到其他用户起动的程序pid

  -r  显示路由表
  -c  每隔一段时间(秒)，执行该netstat命令
  -i  显示各个网络接口的状况 
  -s  按照协议进行统计

  
  前面锁所示的 -antp  大家可以对照看一下


TCP端口状态


  TCP端口有如下几个常见的状态
  1.LISTENING    对应netstat的LISTEN   我们开一个80端口的服务，也就是使80端口处于LISTEN状态，
                 这样浏览器就可以与我们的80端口进行连接
  2.ESTABLISED   表示两个端口建立连接成功，正在通信
  3.CLOSE_WAIT   对方主动关闭连接或者网络异常导致连接中断，这时我方的状态就会变为CLOSE_WAIT, 
                 此时我方要主动调用close()来关闭连接
  4.TIME_WAIT    我方主动调用close()断开连接，收到对方确认后变为TIME_WAIT. 
                 TCP协议规定TIME_WAIT状态会一直持续2MSL(两倍的分段最大生存期)，
                 以此确保旧的连接状态不会对新连接产生影响。处于TIME_WAIT状态的连接不会被内核释放，
                 所以作为服务器，在可能的情况下，尽量不要主动断开连接，以减少TIME_WAIT状态造成的资源浪费。
                 

-a 参数


  show both listening and none-listening sockets.默认是不显示listening sockets
  
  $netstat 
  Proto Recv-Q Send-Q Local Address               Foreign Address             State
  tcp        0      0 hu_bo1:47054                hu_bo1:8961                 TIME_WAIT
  tcp        0      0 hu_bo1:6981                 192.168.6.80:54645          ESTABLISHED
  tcp       41      0 localhost:8092              localhost:25272             CLOSE_WAIT
  
  $netstat -a
  tcp        0      0 *:acnet                     *:*                         LISTEN    #多了这个
  tcp        0      0 hu_bo1:47054                hu_bo1:8961                 TIME_WAIT
  tcp        0      0 hu_bo1:6981                 192.168.6.80:54645          ESTABLISHED
  tcp       41      0 localhost:8092              localhost:25272             CLOSE_WAIT

  其中Recv-Q 表示接受队列  Send-Q表示发送队列  这些数字一般是0,如果不是则表示网络包正在堆积

-t 参数


  只显示tcp端口 默认是全部显示
  $netstat 
  Proto Recv-Q Send-Q Local Address               Foreign Address             State
  tcp        0      0 hu_bo1:47054                hu_bo1:8961                 TIME_WAIT
  tcp        0      0 hu_bo1:6981                 192.168.6.80:54645          ESTABLISHED
  tcp       41      0 localhost:8092              localhost:25272             CLOSE_WAIT
  tcp        0      0 SHTU-ABC-05.abc:griffin     SHTU-REDIS-21-104.abc:6062 ESTABLISHED
  Active UNIX domain sockets (w/o servers)
  Proto RefCnt Flags       Type       State         I-Node Path               
  unix  7      [ ]         DGRAM                    74370628 /dev/log
  unix  2      [ ]         DGRAM                    834846110
  
  其中Active UNIX doamin sockets 为Unix域套接字，只能用于本机进程间通讯，性能比TCP高
  
  $netstat -t
  Proto Recv-Q Send-Q Local Address               Foreign Address             State
  tcp        0      0 hu_bo1:47054                hu_bo1:8961                 TIME_WAIT
  tcp        0      0 hu_bo1:6981                 192.168.6.80:54645          ESTABLISHED
  tcp       41      0 localhost:8092              localhost:25272             CLOSE_WAIT
  tcp        0      0 SHTU-ABC-05.abc:griffin     SHTU-REDIS-91-14.abc:6062   ESTABLISHED


-u 参数


  只显示udp 端口，默认是全部显示


-n 参数


  -n  拒绝显示别名，显示数字
  $netstat
  Proto Recv-Q Send-Q Local Address               Foreign Address             State
  tcp        0      0 hu_bo1:47054                hu_bo1:8961                 TIME_WAIT
  tcp        0      0 hu_bo1:6981                 192.168.6.80:54645          ESTABLISHED
  tcp       41      0 localhost:8092              localhost:25272             CLOSE_WAIT
  tcp        0      0 SHTU-ABC-05.abc:griffin     SHTU-REDIS-21-104.abc:6062 ESTABLISHED
  
  
  如下所示，显示的都是ip地址
  $netstat -n
  tcp        0      0 192.168.17.13:47054         192.168.17.13:8961          TIME_WAIT
  tcp        0      0 192.168.17.13:6981          192.168.6.80:54645          ESTABLISHED
  tcp       41      0 127.0.0.1:8092              127.0.0.1:25272             CLOSE_WAIT


-l 参数


  -l  仅列出有在Listen(监听)的服务状态
  
  $netstat -l
  tcp        0      0 hu_bo1:6981                 *:*                         LISTEN
  tcp        0      0 *:2189                      *:*                         LISTEN
  tcp        0      0 hu_bo1:11213                *:*                         LISTEN
  tcp        0      0 hu_bo1:6586                 *:*                         LISTEN


-p 参数


  -p  显示建立相关连接的程序名   需要sudo才能看到其他用户起动的程序pid
  
  $sudo netstat -p
  tcp        0      0 hu_bo1:6981                 192.168.77.80:52256         ESTABLISHED 6458/redis-server 1
  tcp        0      0 hu_bo1:6980                 hu_bo1:11802                ESTABLISHED 6418/redis-server 1
  tcp        0      0 hu_bo1:6980                 192.168.77.80:65120         ESTABLISHED 6418/redis-server 1 


-r 参数


  -r 显示路由表
  $ netstat -r
  Kernel IP routing table
  Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
  192.168.77.0     *              255.255.255.0   U         0 0          0 em2
  link-local      *               255.255.0.0     U         0 0          0 em1
  link-local      *               255.255.0.0     U         0 0          0 em2
  192.168.0.0     192.168.77.1    255.255.0.0     UG        0 0          0 em2


-i 参数


  -i 显示各个网络接口的状况
  
  $netstat -i
  Kernel Interface table
  Iface       MTU  Met  RX-OK      RX-ERR RX-DRP RX-OVR   TX-OK       TX-ERR TX-DRP TX-OVR  Flg
  em1        1500   0 120567162       0      0      0     90527177      0      0      0     BMRU
  em2        1500   0 5357249686      0      0      0     4400173145    0      0      0     BMRU
  lo        65536   0 49625810403     0      0      0     49625810403   0      0      0     LRU
  
  参数解释
  RX-OK   接收时，正确的数据包数
  RX-ERR  接受时，错误的数据包数
  RX-DRP  接受时，丢弃的数据包数
  RX-OVR  接收时，由于过速（在数据传输中，由于接收设备不能接收按照发送速率传送来的数据而使数据丢失）而丢失的数据包数。
  TX-OK   发送时，正确的数据包数。
  TX-ERR  发送时，产生错误的数据包数。
  TX-DRP  发送时，丢弃的数据包数。
  TX-OVR  发送时，由于过速而丢失的数据包数。
  
  Flg
  标志。
  B 已经设置了一个广播地址。
  L 该接口是一个回送设备。
  M 接收所有数据包（混乱模式）。
  N 避免跟踪。
  O 在该接口上，禁用ARP。
  P 这是一个点到点链接。
  R 接口正在运行。
  U 接口处于“活动”状态。


-c 参数


  $netstat -p -c 10   每隔10秒执行一次该命令


-s 参数


  -s 按照协议进行统计   如果机器网络不太好的情况下，我们可以使用此参数来进行分析
