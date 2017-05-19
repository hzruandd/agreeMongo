sh.addShard("127.0.0.1:27018");

sleep(300) /* wait replica set be ready.*/
var result = sh.addShard("replset/127.0.0.1:27027,127.0.0.1:27028,127.0.0.1:27029");
if(result["ok"] == 0)
{
    print("Error: " + result["errmsg"]);
}
else
{
    print("========> Init shard cluster [sharding] success! <========");
}
