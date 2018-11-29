#! /bin/sh
# file: examples/equality_test.sh

source ./run.sh

initialRebootFile >null
clearLargeFile >null
CreateMountedPATH_and_availableSizeArray >null
checkAvailableSizeAndGenerateLargeFile >null
testEquality() {
	cap=$(checkCapacityAndRunReboot)
	assertEquals $cap "Full"
}

# load shunit2
. ./src/shell/shunit2
