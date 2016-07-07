#MongoDB安全部署

1、开启验证，auth=true
2、添加用户权限管理，对用户动作做细粒度控制 https://docs.mongodb.com/manual/reference/user-privileges/
3、防火墙、安全组、iptables、netfilter
4、使用key文件建立复制服务器集群-指定共享的key文件，启用复制集群的MongoDB实例之间的通信。keyFile = /srv/mongodb/keyfile 
5、禁止HTTP状态接口- 默认情况下Mongodb在端口28017上运行http接口。
nohttpinterface = true 
6、禁止REST接口-在生产环境下建议不要启用MongoDB的REST接口。这个接口不支持任何认证。rest=false
7、使用"bind_ip"选项限制mongodb服务器只在与该配置项关联的接口上侦听。默认情况下mongoDB绑定所有的接口。
bind_ip = 10.10.0.25,10.10.0.26 
8、启用SSL- 防止数据被窃听、篡改。保障mongoDB的客户端和mongoDB服务器传输数据是被加密的。
9、记录数据库操作日志并对其进行审计https://docs.mongodb.com/master/core/auditing/#auditing。
10、认证服务LDA phttps://docs.mongodb.com/master/tutorial/configure-ldap-sasl-openldap/、
11、x.509证书认证 http://docs.mongodb.org/master/tutorial/configure-x509/
