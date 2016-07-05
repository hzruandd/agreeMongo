#Traffic to and from mongod Instances
iptables -A INPUT -s <ip-address> -p tcp --destination-port 27017 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -d <ip-address> -p tcp --source-port 27017 -m state --state ESTABLISHED -j ACCEPT
ip-address such as: 180.97.33.108,10.10.10.10/24,10.10.10.10/255.255.255.0

#Traffic to and from mongos Instances
#the same to <Traffic to and from mongod Instances>


#Traffic to and from a MongoDB Config Server
iptables -A INPUT -s <ip-address> -p tcp --destination-port 27019 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -d <ip-address> -p tcp --source-port 27019 -m state --state ESTABLISHED -j ACCEPT

#Additionally, config servers need to allow incoming connections from all of
#the mongos instances in the cluster and all mongod instances in the cluster.
#Add rules that resemble the following
iptables -A INPUT -s <ip-address> -p tcp --destination-port 27019 -m state --state NEW,ESTABLISHED -j ACCEPT

#Traffic to and from a MongoDB Shard Server
iptables -A INPUT -s <ip-address> -p tcp --destination-port 27018 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -d <ip-address> -p tcp --source-port 27018 -m state --state ESTABLISHED -j ACCEPT
#This allows you to permit incoming and outgoing traffic between all shards
#including constituent replica set members, to:
#all mongod instances in the shard’s replica sets.
#all mongod instances in other shards

#Provide Access For Monitoring Systems
#The mongostat diagnostic tool, when running with the --discover needs to be
#able to reach all components of a cluster, including the config servers, the
#shard servers, and the mongos instances.
#
iptables -A INPUT -s <ip-address> -p tcp --destination-port 28017 -m state --state NEW,ESTABLISHED -j ACCEPT


#Change Default Policy to DROP
iptables -P INPUT DROP

iptables -P OUTPUT DROP


#Make all iptables Rules Persistent
#Red Hat Enterprise Linux, Fedora Linux
service iptables save

#Debian, Ubuntu
iptables-save > /etc/iptables.conf
