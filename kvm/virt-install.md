virt-install --connect qemu:///system -n guest2-rhel6.5 -r 4906 -f
/rdd/images/guest2-rhel6.1.img -s 16  --os-type=linux --os-variant=rhel6
--vcpus=4 --network network=default -c
/home/rdd/images/rhel-server-6.5-x86_64-dvd.iso  --accelerate --vnc

virt-install --connect qemu:///system -name guest2-rhel6.1 --ram 4096 --disk
path=/rdd/images/guest2-rhel6.1.img -s 16 --network network:default --cdrom
/rdd/rhel-server-6.5-x86_64-dvd.iso --os-type=inux --accelerate --vnc


virt-install --connect qemu:///system -n guest2-rhel6.1 -r 4906 -f
/rdd/images/guest2-rhel6.1.img -s 16  --os-type=linux --os-variant=rhel6
--vcpus=4 --network network=default --cdrom
/home/rdd/rhel-server-6.5-x86_64-dvd.iso  --accelerate --vnc


qemu-kvm -name centos6 -smp 1 -m 512 \
-drive
file=/root/rdd/images/centos6.qcow2,if=virtio,media=disk,index=0,format=qcow2 \
-drive file=/home/rdd/images/rhel-server-6.5-x86_64-dvd.iso,index=1,media=cdrom
\
-net nic,model=virtio \
-net tap,ifname=vnet0cript=/etc/qemu-ifup,downscript=no \
-vga cirrus -balloon virtio



sudo virt-install --connect qemu:///system -n rhel6.5 -r 1024 --vcpus=2 --disk
path=/var/lib/libvirt/images/rhel6.5.imgize=2 --graphics vnc,listen=0.0.0.0
--os-type linux --os-variant rhel6 --accelerate --network=bridge:virbr0 --hvm
--cdrom /home/rdd/images/rhel-server-6.5-x86_64-dvd.iso



sudo virt-install --connect qemu:///system -n vmdeb7 -r 512 --vcpus=1 --disk
path=/var/lib/libvirt/images/vmdeb7.imgize=2 --graphics vnc,listen=0.0.0.0
--noautoconsole --os-type linux --os-variant debianwheezy --accelerate
--network=bridge:virbr0 --hvm --cdrom /tmp/debian-7.5.0-amd64-netinst.iso
