#!/bin/sh
# ==============================================================================
# =           Initial block                                                    =
# ==============================================================================
# ----- Add the start / end time and calculate diff time -----------------------
# start=`date +%s`
# echo start=$start
# # function here
# end=`date +%s`
# echo end=$end
# dif=`expr $end - $start`
# echo $dif

# ----- Initial reboot script file and set into rc.local/boot.local ------------
# This version supprt CentOS7 as first release
initialRebootFile(){
    sed -i '/sh \/tmp\/count.sh \&/d' /etc/rc.d/rc.local
    if [ -e "/tmp/count.sh"  ]
    then
        rm -f /tmp/count.sh
        sh scripts/setReboot.sh
        echo "sh /tmp/count.sh &" >>  /etc/rc.d/rc.local
    else
        sh scripts/setReboot.sh
        echo "sh /tmp/count.sh &" >>  /etc/rc.d/rc.local
    fi
}

# --------------- Initial large file.txt by remove file.txt -------------------
clearLargeFile() {
	start=$(date +%s)
	echo "clear large file start=$start"
	# # function here

	df -P | awk '{print $6}' | while read partition; do
		if [ -e "$partition/file.txt" ]; then
			rm -f $partition/file.txt
			echo "------ Remove $partition/file.txt ------"
		fi
	done
	## -------------- echo clear file.txt finish message -------------
	echo "=============================="
	echo "== clear file.txt finish ====="
	echo "=============================="
	end=$(date +%s)
	echo "clear large file end=$end"
	dif=$(expr $end - $start)
	echo "Time interval of clear large file=$dif"
}

# ----------------------------------------------------------------------------

# ===============================================================================
# This command will create a file of size count*bs bytes,
# ex:
#   dd if=/dev/zero of=file.txt count=1024 bs=1024
# which in the above case will be 1MB.
# ===============================================================================
#
# List out the disk partition available size and path
# Command ex:
#   df -P | awk '{print $6}' <!--to print the mount path -->
#
# To dump the current available partition size of each disk partition

# -- Create mounted_PATH and availableSize array --

CreateMountedPATH_and_availableSizeArray() {
	mountedPATH_array=($(df -P | awk '/\// {print  $6}'))
	availableSizeCurrent_array=($(df -P | awk '/\// {print  $4}'))
}

checkAvailableSizeAndGenerateLargeFile() {
	# mountedPATH_array=($(df -P | awk '/\// {print  $6}'))
	# availableSizeRemain_array=($(df -P | awk '/\// {print  $4}'))

	partition_num=${#mountedPATH_array[@]}
	for chk_par in $(seq 0 $(expr $partition_num - 1)); do
		echo "currentPATH=${mountedPATH_array[$chk_par]}"
		echo "availableSize=${availableSizeCurrent_array[$chk_par]}"
		# Calculate the count value the assign to variable cnt with formular : availableSize*1024/MB
		# 1MB = 1*1024*1024 = 1048576 bytes
		cnt=$((availableSizeCurrent_array[$chk_par] * 1024 / 1048576))
		dd if=/dev/zero of=/dev/file.txt count=$cnt bs=1048576 #1GB=1073741824 Bytes
	done

	end=$(date +%s)
	echo "end generate /dev/file.txt=$end"
	dif=$(expr $end - $start)
	echo "Time interval of file.txt generation=$dif"
}

# Check the remained disk partition available size after generate the big sized file.
checkAvailableSizeRemain() {
	# mountedPATH_array=($(df -P | awk '/\// {print  $6}'))
	# availableSizeRemain_array=($(df -P | awk '/\// {print  $4}'))

	partition_num=${#mountedPATH_array[@]}
	for chk_par in $(seq 0 $(expr $partition_num - 1)); do
		echo "currentPATH=${mountedPATH_array[$chk_par]}"
		echo "availableSizeRemain=${availableSizeRemain_array[$chk_par]}"
	done
}

# Check the capacity and trigger reboot action
checkCapacityAndRunReboot() {
	# mountedPATH_array=($(df -P | awk '/\// {print  $6}'))
	# availableSizeRemain_array=($(df -P | awk '/\// {print  $4}'))

	# check the capacity %
	capacityArray=$(df -P | awk '/\// {gsub("%","",$5);print $5}')

	# If capacity is full (100%), trigger the reboot funciton
	for par in $(seq 0 $(expr ${#capacityArray[@]} - 1)); do
		if [ ${capacityArray[par]} -lt 90 ]; then
			echo "NotFullCap"
			return 1 # 1: fail
		fi
	done
	echo "Full"
	sh /tmp/count.sh
}

# while read partition availableSizeCurrent
# do
#    cnt=$((availableSizeCurrent*1024/1048576))
#    dd if=/dev/zero of=/dev/file.txt count=$cnt bs=1048576
#    availableSizeRemain=`df -P | awk '{print $4}'`
#    echo "availableSizeRemain : $partition : $availableSizeRemain"
# #    echo $partition , $availableSizeCurrent
# done <<< "`df -P | awk '{print $6, $4}'`"

initialRebootFile
clearLargeFile
CreateMountedPATH_and_availableSizeArray
checkAvailableSizeAndGenerateLargeFile
checkAvailableSizeRemain
checkCapacityAndRunReboot
