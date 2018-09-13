#!/bin/sh

# Recording the exectue date

beginDate(){
	[ -e "/tmp/beginTimeStamp.log" ] || { 
		echo `date +%s` > /tmp/beginTimeStamp.log;
		return 0;  
	}
}
recordDate() {
	echo $c >> /tmp/date.log
	echo `date` >> /tmp/date.log
	begin=`cat /tmp/beginTimeStamp.log`
	lastDate=`date +%s`
	diff=`expr $lastDate - $begin`
	diffMin=$((diff/60))
	diffHrs=$((diffMin/60))
	echo "Currently test : $diffMin minutes; $diffHrs hrs" >> /tmp/date.log
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
	idleAndReboot 300
else
    c=`cat /tmp/clog.log`
    ((c++))
    echo $c > /tmp/clog.log
	recordDate
	idleAndReboot 300
fi
}

# execution area
beginDate
reboot_main
