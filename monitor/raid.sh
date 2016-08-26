
#获取机器型号，厂商，序列号信息
dmidecode | grep -B 4 "Serial Number"  | head -n 11

#获取cpu信息，如果有CPU1,CPU2标示是多核
dmidecode | grep  "CPU" 


#first, check and install it
which megacli

wget http://ftp.cs.stanford.edu/pub/rpms/centos/5/x86_64/Lib_Utils-1.00-08.noarch.rpm
wget http://ftp.cs.stanford.edu/pub/rpms/centos/5/x86_64/MegaCli-8.00.46-1.i386.rpm

rpm -ivh Lib_Utils-1.00-08.noarch.rpm
rpm -ivh MegaCli-8.00.46-1.i386.rpm

#second
cp /opt/MegaRAID/MegaCli/MegaCli64 /usr/local/sbin/megacli


#usage
"""-LDInfo -Lall -aALL 
-LDInfo -Lall -aALL 查raid级别
-AdpAllInfo -aALL 查raid卡信息
-PDList -aALL 查看硬盘信息
-AdpBbuCmd -aAll 查看电池信息
-FwTermLog -Dsply -aALL 查看raid卡日志
-adpCount 显示适配器个数
-AdpGetTime –aALL 显示适配器时间
-AdpAllInfo -aAll    显示所有适配器信息
-LDInfo -LALL -aAll    显示所有逻辑磁盘组信息
-PDList -aAll    显示所有的物理信息
-AdpBbuCmd -GetBbuStatus -aALL |grep ‘Charger Status’
-AdpBbuCmd -GetBbuStatus -aALL显示BBU状态信息
-AdpBbuCmd -GetBbuCapacityInfo -aALL显示BBU容量信息
-AdpBbuCmd -GetBbuDesignInfo -aALL    显示BBU设计参数
-AdpBbuCmd -GetBbuProperties -aALL    显示当前BBU属性
-cfgdsply -aALL    显示Raid卡型号，Raid设置，Disk相关信息
"""

#当前 RAID 数量
megacli -cfgdsply -aALL |grep "Number of DISK GROUPS:"  

#RAID 卡信息
megacli -cfgdsply –aALL  | more 

#缓存及策略
megacli  -cfgdsply -aALL |grep Policy

#查看磁盘缓存策略
megacli -LDGetProp -Cache -L0 -a0 
megacli -LDGetProp -Cache -L1 -a0 

#set the cache policy

"""
WT    (Write through)  
WB    (Write back)  
NORA  (No read ahead)  
RA    (Read ahead)  
ADRA  (Adaptive read ahead)  
Cached  
Direct  
  
-RW|RO|Blocked|RemoveBlocked | WT|WB|ForcedWB [-Immediate] |RA|NORA | DsblP |
Cached|Direct | -EnDskCache|DisDskCache | CachedBadBBU|NoCachedBadBBU  
        -Lx|-L0,1,2|-Lall -aN|-a0,1,2|-aALL """ 

megacli -LDSetProp WT -L0 -a0  

#close the cache
megacli -LDSetProp -DisDskCache -L0 -a0 

#
megacli -PDList -aALL | grep -E "Drive\:\ \ Not\ Supported|Slo" 

#smartctl
"""
-i <device> ：显示设备的身份信息，检查硬盘是否打开了SMART支持。
-H <device> ：查看硬盘的健康状况。
-A <device> ：显示设备SMART厂商属性和值。
-l error <device> ：显示硬盘历史错误信息。
-l selftest <device> ：显示硬盘测试信息。

"""
