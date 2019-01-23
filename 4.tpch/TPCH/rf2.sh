#!/bin/sh
#RF delete for Throughput test

PARA=${1}

RF2START=`date +%Y-%m-%d\ %H:%M:%S`
	cd ./RF; ./RF2 delete.$PARA > ../outfile/RF2_$PARA.out
RF2END=`date +%Y-%m-%d\ %H:%M:%S`
	echo "start: $RF2START , end: $RF2END" >> ../outfile/RF2_$PARA.out
