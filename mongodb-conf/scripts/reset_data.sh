#!/usr/bin/env bash

THIS_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $(dirname $THIS_DIR)
WORK_DIR=`pwd`

if [ $OS = "Linux" ];then
    find $WORK_DIR -type f -name *.conf | xargs sed -i "s#$WORK_DIR#{{ path }}#g"
else  # Mac OSX
    find $WORK_DIR -type f -name *.conf | xargs gsed -i "s#$WORK_DIR#{{ path }}#g"
fi
find $WORK_DIR -type f -name *.log -exec rm {} \;
find $WORK_DIR -type f -name *.pid -exec rm {} \;
for i in `find $WORK_DIR -maxdepth 3 -type d`;
    do if [ $(basename $i) = data ];then
        cd $i
        /bin/rm -fr *
    fi
    done;
