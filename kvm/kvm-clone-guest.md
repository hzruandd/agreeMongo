kvm clone网卡问题
 
在使用KVM clone 虚机时，遇到新虚机的网卡启动时，变成eth1。很无语。面对该问题，修改了几项。 
 
1， KVM的模板，需要注释掉的/etc/sysconfig/network-script/ifcfg-eth0中HWADDR和UUID信息 
 
2， 用KVM模板clone出虚机，就不用修改新虚机的UUID信息和HWADDR的信息,其他信息依旧。 
 
3， virsh edit newserver 查看新虚机的网卡地址。保存到一个文件。 
 
4， 通过VNC或console 进入虚机，修改/etc/udev/rules.d/70-persistent-net.rules 
    
    只保留eth0的信息，并修改网卡地址为新虚机的网卡地址。 
 
5， virsh destroy newserver && virsh start newserver 
