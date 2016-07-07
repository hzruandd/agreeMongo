#配置mongod Instances
    iptables -A INPUT -s <ip-address> -p tcp --destination-port 27017 -m state --state NEW,ESTABLISHED -j ACCEPT
    iptables -A OUTPUT -d <ip-address> -p tcp --source-port 27017 -m state --state ESTABLISHED -j ACCEPT
    ip-address such as: 180.97.33.108,10.10.10.10/24,10.10.10.10/255.255.255.0

#配置mongos Instances
#此处配置同上mongod Instances


#配置MongoDB Config Server
iptables -A INPUT -s <ip-address> -p tcp --destination-port 27019 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -d <ip-address> -p tcp --source-port 27019 -m state --state ESTABLISHED -j ACCEPT

#因为所有mongos需要连接到config服务器，而config和mongod也需要连接，故：
iptables -A INPUT -s <ip-address> -p tcp --destination-port 27019 -m state --state NEW,ESTABLISHED -j ACCEPT

#配置MongoDB Shard Server
iptables -A INPUT -s <ip-address> -p tcp --destination-port 27018 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -d <ip-address> -p tcp --source-port 27018 -m state --state ESTABLISHED -j ACCEPT

#此处配置准许MongoDB的Monitoring Systems
iptables -A INPUT -s <ip-address> -p tcp --destination-port 28017 -m state --state NEW,ESTABLISHED -j ACCEPT


#Change Default Policy to DROP
iptables -P INPUT DROP

iptables -P OUTPUT DROP


#由于iptables的配置是保留在内存中，服务器关机后就丢失了，故需要落地：
#Red Hat Enterprise Linux, Fedora Linux
service iptables save

#Debian, Ubuntu
iptables-save > /etc/iptables.conf
