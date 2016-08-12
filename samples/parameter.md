##disableJavaScriptJIT
    mongod --setParameter disableJavaScriptJIT=true

##Logging Parameters

###logLevel
Specify an integer between 0 and 5 signifying the verbosity of the logging,
where 5 is the most verbose.

Consider the following example which sets the logLevel to 2:

    use admin
    db.runCommand( { setParameter: 1, logLevel: 2 } ) } )




The components correspond to the following settings:

accessControl
command
control
geo
index
network
query
replication
sharding
storage
storage.journal
write

Unless explicitly set, the component has the verbosity level of its parent. For
example, storage is the parent of storage.journal. 

For example, the following sets the default verbosity level to 1, the query to
2, the storage to 2, and the storage.journal to 1.

    use admin
    db.runCommand( {
        setParameter: 1,logComponentVerbosity: {
      verbosity: 1,
      query: { verbosity: 2 },
      storage: {
         verbosity: 2,
         journal: {
            verbosity: 1
         }
      }
   }
} )

###quiet
Available for both mongod and mongos.

Sets quiet logging mode. If 1, mongod will go into a quiet logging mode which
will not log the following events/activities:

connection events;

the drop command, the dropIndexes command, the diagLogging command, the
validate command, and the clean command;

replication synchronization activities.

    db = db.getSiblingDB("admin")
    db.runCommand( { setParameter: 1, quiet: 1 } ) } )

###traceExceptions
If true, mongod will log full stack traces.
    db.getSiblingDB("admin").runCommand( { setParameter: 1, traceExceptions:
    true } )

#Replication Parameters
##replIndexPrefetch

By default secondary members of a replica set will load all indexes related to
an operation into memory before applying operations from the oplog. You can
modify this behavior so that the secondaries will only load the _id index.
Specify _id_only or none to prevent the mongod from loading any index into
memory.

The default value is all and available options are:

none
all
_id_only

##replWriterThreadCount

New in version 3.2.

Type: integer

Default: 16

Available for mongod only.

Number of threads to use to apply replicated operations in parallel. Values can
range from 1 to 256 inclusive. You can only set replWriterThreadCount at
startup and cannot change this setting with the setParameter command.

#Sharding Parameters
##journalCommitInterval
Specify an integer between 1 and 500 signifying the number of milliseconds (ms)
between journal commits.
    db.getSiblingDB("admin").runCommand( { setParameter: 1,
    journalCommitInterval: 200 } )

##syncdelay
    db.getSiblingDB("admin").runCommand( { setParameter: 1, syncdelay: 60 } )


#WiredTiger Parameters
##wiredTigerConcurrentReadTransactions
Specify the maximum number of concurrent read transactions allowed into the
WiredTiger storage engine.
    db.adminCommand( { setParameter: 1, wiredTigerConcurrentReadTransactions:
    <num> } ) 

##wiredTigerConcurrentWriteTransactions
Specify the maximum number of concurrent write transactions allowed into the
WiredTiger storage engine.
    db.adminCommand( { setParameter: 1, wiredTigerConcurrentWriteTransactions:
    <num> } )


