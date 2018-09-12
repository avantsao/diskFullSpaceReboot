#!/bin/sh

# Recording the exectue date
recordDate() {
	echo $c >> /tmp/date.log
	echo `date` >> /tmp/date.log
	echo "=======" >> /tmp/date.log
}

# Idle 6c sec and do init 6
idleAndReboot(){
    sleep $1
    init 6
}

# code main entry
reboot_main(){
if [ ! -e "/tmp/clog.log" ]
then
    echo 1 > /tmp/clog.log
	recordDate
	idleAndReboot
else
    c=`cat /tmp/clog.log`
    ((c++))
    echo $c > /tmp/clog.log
	recordDate
	idleAndReboot 300
fi
}

# execution area
reboot_main
