#!/bin/sh

# ===============================================================================
# This command will create a file of size count*bs bytes,
# ex:
#   dd if=/dev/zero of=file.txt count=1024 bs=1024 
# which in the above case will be 1MB.
# ===============================================================================

# List out the disk partition available size and path
# Command ex: 
#   df -P | awk '{print $6}' <!--to print the mount path -->

# To dump the current available partition size of each disk partition
# Below jsut take /dev partition for example 
availableSizeCurrent=`df -P | awk '/dev$/ {print  $4}'` 
echo "availableSize=$availableSizeCurrent"

# Calculate the count value the assign to variable cnt with formular : availableSize*1024/MB
# 1MB = 1*1024*1024 = 1048576 bytes 
cnt=$((availableSizeCurrent*1024/1048576))
dd if=/dev/zero of=/dev/file.txt count=$cnt bs=1048576 #1GB=1073741824 Bytes

# Check the remained disk partition available size after generate the big sized file.  
availableSizeRemain=`df -P | awk '/dev$/ {print $4}'` 
echo "availableSizeRemain : $availableSizeRemain"

#echo "count=$cnt"

# while read partition availableSizeCurrent
# do
#    cnt=$((availableSizeCurrent*1024/1048576))
#    dd if=/dev/zero of=/dev/file.txt count=$cnt bs=1048576  
#    availableSizeRemain=`df -P | awk '{print $4}'`
#    echo "availableSizeRemain : $partition : $availableSizeRemain"
# #    echo $partition , $availableSizeCurrent
# done <<< "`df -P | awk '{print $6, $4}'`"