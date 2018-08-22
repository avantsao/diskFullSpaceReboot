#! /bin/sh
# file: examples/equality_test.sh

source ./run.sh

initialRebootFile
clearLargeFile
checkAvailableSizeAndGenerateLargeFile
testEquality()
{
  cap=$(checkCapacityAndRunReboot)
  assertEquals $cap "Full"
}

# load shunit2
. ./src/shell/shunit2
