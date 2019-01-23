#!/bin/sh

PARA=${1}

RF1START=`date +%Y-%m-%d\ %H:%M:%S`
	cd ./RF; ./RF1 $PARA > ../outfile/RF1_$PARA.out
RF1END=`date +%Y-%m-%d\ %H:%M:%S`
	echo "start: $RF1START , end: $RF1END" >> ../outfile/RF1_$PARA.out
