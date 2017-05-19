config = { _id:"shard1", members:[                                                 
                     {_id:0,host:"10.8.6.125:27017"},                              
                     {_id:1,host:"10.8.6.126:27017"},                              
                     {_id:2,host:"10.8.6.140:27017",arbiterOnly:true}              
                ]                                                                  
         }                                                                         
                                                                                                                                                     
rs.initiate(config);
db.runCommand( { addshard : "shard1/10.8.6.125:27017,10.8.6.126:27017,10.8.6.140:27017"});



config = { _id:"shard2", members:[                                                 
                     {_id:0,host:"10.8.6.115:27017"},                              
                     {_id:1,host:"10.8.6.116:27017"},                              
                     {_id:2,host:"10.8.6.117:27017",arbiterOnly:true}              
                ]                                                                  
         }                                                                         
                                                                                                                                                     
rs.initiate(config);

db.runCommand( { addshard : "shard2/10.8.6.115:27017,10.8.6.116:27017,10.8.6.117:27017"});


config = { _id:"shard3", members:[                                                 
                     {_id:0,host:"10.8.6.118:27017"},                              
                     {_id:1,host:"10.8.6.119:27017"},                              
                     {_id:2,host:"10.8.6.141:27017",arbiterOnly:true}              
                ]                                                                  
         }                                                                         
                                                                                                                                                     
rs.initiate(config);

db.runCommand( { addshard : "shard3/10.8.6.118:27017,10.8.6.119:27017,10.8.6.141:27017"});
