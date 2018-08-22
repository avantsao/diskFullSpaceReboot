#!/bin/sh

sh equality_test.sh > results/result_equality_test.xml
sh lineno_test.sh > results/result_lineno_test.xml
sh math_test.sh > results/result_math_test.xml
sh mkdir_test.sh > results/result_mkdir_test.xml
sh party_test.sh > results/result_party_test.xml

