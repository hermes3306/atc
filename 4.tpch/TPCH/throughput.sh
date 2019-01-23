#!/bin/sh

COUNT="1"
SEEDNUM=$1

#Make Throughput Query Directory
rm -rf $TPCH_HOME/query/*_query

DIRCNT="1"
while [ $DIRCNT -le $STREAM ]
do
    mkdir $TPCH_HOME/query/${DIRCNT}_query
    DIRCNT=`expr $DIRCNT + 1`
done

#Make Throughput Query
cd $DBGEN_HOME

while [ $COUNT -le $STREAM ]
do
    SEEDNUM1=`expr $SEEDNUM + $COUNT`
    QUERYNUM="1"

    while [ $QUERYNUM -le 22 ]
    do
        ./qgen -r $SEEDNUM1 -p $COUNT -x $QUERYNUM > T$QUERYNUM.sql
	QUERYNUM=`expr $QUERYNUM + 1`
    done

    mv T*.sql $TPCH_HOME/query/${COUNT}_query
    COUNT=`expr $COUNT + 1`
done

#Excute stream
cd $TPCH_HOME
EXECUTE_COUNT="1"
while [ $EXECUTE_COUNT -le $STREAM ]
do
    sh stream.sh $EXECUTE_COUNT &
    EXECUTE_COUNT=`expr $EXECUTE_COUNT + 1`
done
wait
