#!/bin/sh

if [ ! -e "/tmp/clog.log"]
then
    echo 1 > /tmp/clog.log
else
    c=`cat /tmp/clog.log`
    ((c++))
    echo $c > /tmp/clog.log
    sleep 300
    init 6
fi
