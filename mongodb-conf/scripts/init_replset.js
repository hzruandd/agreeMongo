var result = rs.initiate({ "_id" : "replset", "members" : [
                { "_id" : 1, "host" : "127.0.0.1:27027"},
                { "_id" : 2, "host" : "127.0.0.1:27028"},
                { "_id" : 3, "host" : "127.0.0.1:27029"},
                ]});

if(result["ok"] == 0)
{
    print("Error: " + result["errmsg"]);
}
else
{
    print("========> Init replica set [replset] success! <========");
}


//
//如果不想让一个从节点成为主节点可以怎么操作？
//a、使用rs.freeze(120)冻结指定的秒数不能选举成为主节点。
//b、按照上一篇设置节点为Non-Voting类型。
//
//
//
//
//
//
//
//
//
