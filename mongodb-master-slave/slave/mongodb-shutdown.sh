#!/bin/bash


MONGODB_CONF=/home/test/mongodb-test/mongodb-master-slave/slave/etc/mongodb.conf


echo "MONGODB_CONF:$MONGODB_CONF"


mongod -f $MONGODB_CONF --shutdown


