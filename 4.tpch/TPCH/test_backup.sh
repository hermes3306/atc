#!/bin/sh

. ./set_test.env

while getopts "s:c:" arg
do
    case $arg in
    s) export SCALE=$OPTARG ;;
    c) export STREAM=$OPTARG ;;
    esac
done

#Split Count
if [ $SCALE -gt 30 ]
then
    export SPCOUNT=`expr $SCALE / 10`
else
    export SPCOUNT=1
fi

#RF make
cd ./RF; make clean;  make

#QphH make
cd $QPHH; rm -f *.log; make clean; make

cd $TPCH_HOME
#DB CLEAN
sh clean.sh

#CREATE SCHEMA
isql -s $HOST -u $DBUSER -p $DBPASS -port $PORT -f schema.sql -o ./log/schema.out

#CREATE DATA
sh create_data.sh

#CREATE UDATA
sh create_udata.sh

#MAKE TPC-H POWER QUERY
rm -f $TPCH_HOME/query/P*.sql

cd $DBGEN_HOME 

QUERYNUM=1

while [ $QUERYNUM -le 22 ]
do
        ./qgen -r $SEEDNUM -p 0 -x $QUERYNUM > P$QUERYNUM.sql
        QUERYNUM=`expr $QUERYNUM + 1`
done
mv -f P*.sql $TPCH_HOME/query

#DATA LOADING
cd $TPCH_HOME
sh dataload.sh

#CREATE INDEX & CREATE STATICS INFO
isql -s $HOST -u $DBUSER -p $DBPASS -port $PORT -f index.sql -o ./log/index.out
isql -s $HOST -u $DBUSER -p $DBPASS -port $PORT -f stats${SCALE}.sql -o ./log/stats.out

#Outfile log delete
rm -f ./outfile/*.out

#EXECUTE TPC-H POWER QUERY
sh rf1.sh 1

LISTNUM=1

    isql -s $HOST -u $DBUSER -p $DBPASS -port $PORT -silent -f ./parallel.sql -o outfile/parallel.out
while [ $LISTNUM -le 22 ]
do
export LISTNUM;
    isql -s $HOST -u $DBUSER -p $DBPASS -port $PORT -silent -f query/P$LISTNUM.sql -o outfile/P$LISTNUM.out
    
    cd ./outfile
    ELAPSED_COUNT=`cat P$LISTNUM.out | grep "elapsed time" | wc -l`
    if [ $ELAPSED_COUNT = "3" ]
    then
        TPCH_SEC=`grep "elapsed time" P$LISTNUM.out | head -2 | tail -1 | awk '{print $4}'`
        echo $TPCH_SEC >> $QPHH/runP.log
    else
        TPCH_SEC=`grep "elapsed time" P$LISTNUM.out | head -1 | awk '{print $4}'`
        echo $TPCH_SEC >> $QPHH/runP.log
    fi
    cd ..
    LISTNUM=`expr $LISTNUM + 1`
done

sh rf2.sh 1

#Save RF1, RF2 Time for PowerTest
cat ./outfile/RF1_1.out | grep "elapsed time" | awk '{print $4}' >> $QPHH/runP.log
cat ./outfile/RF2_1.out | grep "elapsed time" | awk '{print $4}' >> $QPHH/runP.log

#EXECUTE TPC-H THROUGHPUT QUERY
echo "Throughput Test Start : `date +%Y-%m-%d\ %H:%M:%S`"

thstart=$(date +%s%N)

sh throughput.sh $SEEDNUM

thend=$(date +%s%N)

elapsed=`echo "($thend - $thstart) / 1000000" | bc`
elapsedTime=`echo "scale=2;$elapsed / 1000" | bc`
echo $elapsedTime > $QPHH/runT.log

echo "Throughput Test End : `date +%Y-%m-%d\ %H:%M:%S`"

#Calculate QphH
cd $QPHH; sh final.sh > result.log; cat result.log
