#!/bin/sh

rm -f *log

if [ $SPCOUNT -le 1 ]
then
    for datafile in `ls *tbl`
    do
	loadfile=`echo $datafile | sed 's/.tbl//g'`
        iloader -s $HOST -u $DBUSER -p $DBPASS in -f $loadfile.fmt -d $loadfile.tbl -t '|' -log $loadfile.log -bad $loadfile.bad -array 1000 &
    done
else
    iloader -s $HOST -u $DBUSER -p $DBPASS in -d nation.tbl -f nation.fmt -t '|' -log nation.log
    iloader -s $HOST -u $DBUSER -p $DBPASS in -d region.tbl -f region.fmt -t '|' -log region.log

    for i in `seq 1 $SPCINT`
    do
        iloader -s $HOST -u $DBUSER -p $DBPASS in -d orders.tbl.$i  -f orders.fmt -t '|' -log orders.${i}log -array 1000 &
        iloader -s $HOST -u $DBUSER -p $DBPASS in -d lineitem.tbl.$i -f lineitem.fmt -t '|' -log lineitem.${i}log -array 1000 &
        iloader -s $HOST -u $DBUSER -p $DBPASS in -d customer.tbl.$i -f customer.fmt -t '|' -log customer.${i}log -array 1000 &
        iloader -s $HOST -u $DBUSER -p $DBPASS in -d part.tbl.$i -f part.fmt -t '|' -log part.${i}log -array 1000 &
        iloader -s $HOST -u $DBUSER -p $DBPASS in -d partsupp.tbl.$i -f partsupp.fmt -t '|' -log partsupp.${i}log -array 1000 &
        iloader -s $HOST -u $DBUSER -p $DBPASS in -d supplier.tbl.$i -f supplier.fmt -t '|' -log supplier.${i}log -array 1000 &
    done
fi

wait
