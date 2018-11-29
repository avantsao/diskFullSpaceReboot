#! /bin/sh
# file: examples/equality_test.sh

source ./run.sh

initialRebootFile >null
clearLargeFile >null
checkAvailableSizeAndGenerateLargeFile >null
testEquality() {
	cap=$(checkCapacityAndRunReboot)
	assertEquals "Full" $cap
}

# load shunit2
. ./src/shell/shunit2
