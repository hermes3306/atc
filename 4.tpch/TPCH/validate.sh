#!/bin/sh
i=1
while [ $i -le 22 ]
do
   diff ./lstfile/Q"$i".lst ./outfile/Q"$i".out > ./log/Q"$i".diff
   i=`expr $i + 1`;
done
