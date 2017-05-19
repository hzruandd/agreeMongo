#!/usr/bin/env bash

THIS_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $THIS_DIR

if [ $OS = "Linux" ];then
    find `pwd` -type f -name *.conf | xargs sed -i "s#{{ path }}#`pwd`#g"
else  # Mac OSX
    find `pwd` -type f -name *.conf | xargs gsed -i "s#{{ path }}#`pwd`#g"
fi
source ./scripts/startmongos.conf
