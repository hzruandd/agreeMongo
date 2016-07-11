#3.0之前做用户auth的流程大概如下：
1，首先关闭认证，也就是不带--auth参数，启动mongodb 
2，使用命令行进入mongodb目录，输入mongo命令，默认进入test数据库 
3，use userdb  切换到自己的数据库，输入db，显示userdb 
4，创建用户，角色为dbOwner，数据库为userdb，命令行应该是
  db.createUser({user:'myuser',pwd:'123456',roles:[{role:'dbOwner',db:'userdb'}]}) 
5，切换到admin数据库，use admin，db ，显示admin，db.shutdownServer()关闭服务器，填上认证参数，启动mongodb；


#在3.0之后的版本，创建的用户使用SCRAM-SHA-1认证方式，故需要先删除之前已经创建的用户，修改version，添加新用户。 
use admin
#removing all users
db.system.users.remove({})    

#removing current version
db.system.version.remove({})

db.system.version.insert({ "_id" : "authSchema", "currentVersion" : 3 })

use userdb
db.createUser({user:'myuser',pwd:'123456',roles:[{role:'dbOwner',db:'userdb'}]}) 
