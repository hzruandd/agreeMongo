#db.collection.stats()


##db.collection.stats(scale | options)

###options
indexDetails, boolean, Defaults to false. Only works for WiredTiger storage engine.

    db.restaurants.stats( { scale : 1024 } )

    db.restaurant.stats( { indexDetails : true } )

    db.restaurants.stats(
   {
      'indexDetails' : true,
      'indexDetailsKey' :
      {
         'borough' : 1,
         'cuisine' : 1
      }
   }
)

    db.restaurants.stats(
   {
      'indexDetails' : true,
      'indexDetailsName' : 'borough_1_cuisine_1'
   }
)


    db.collection.storageSize()
    db.collection.totalSize()
    db.collection.totalIndexSize()
    db.collection.renameCollection()
    db.collection.reIndex()
    db.collection.drop()
    db.collection.dropIndex()
    db.collection.dropIndexs()
    db.collection.ensureIndex()
    db.collection.createIndex()
    db.collection.copyTo()
    db.collection.count()
    db.collection.aggregate()
    
