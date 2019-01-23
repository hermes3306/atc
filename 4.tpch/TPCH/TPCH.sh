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

#CREATE INDEX & CREATE STATS INFO
echo
echo -------------------------------------------
echo "$SCALE Data Create Index Start"
echo -------------------------------------------
echo
isql -s $HOST -u $DBUSER -p $DBPASS -port $PORT -f index.sql -o ./log/index.out
echo
echo -------------------------------------------
echo "$SCALE Data Create Index End"
echo -------------------------------------------
echo
echo
echo
echo
echo -------------------------------------------
echo "$SCALE Data STAT Start"
echo -------------------------------------------
echo
isql -s $HOST -u $DBUSER -p $DBPASS -port $PORT -f stats${SCALE}.sql -o ./log/stats.out
echo
echo -------------------------------------------
echo "$SCALE Data STAT End"
echo -------------------------------------------

#Outfile log delete
rm -f ./outfile/*.out

#EXECUTE TPC-H POWER QUERY

echo -------------------------------------------
echo "RF1(rf1.sh 1) START"
echo -------------------------------------------
sh rf1.sh 1
echo -------------------------------------------
echo "RF1(rf1.sh 1) END"
echo -------------------------------------------

QUERYORDER="14 2 9 20 6 17 18 8 21 13 3 22 16 4 11 15 1 10 19 5 7 12"

echo
echo -------------------------------------------
echo "PARALLEL Start"
echo -------------------------------------------
echo

isql -s $HOST -u $DBUSER -p $DBPASS -port $PORT -silent -f ./parallel.sql -o log/parallel.out

echo
echo -------------------------------------------
echo "PARALLEL END"
echo -------------------------------------------
echo
echo

echo
echo -------------------------------------------
echo "RUN POWER START"
echo -------------------------------------------
echo

for LISTNUM in $QUERYORDER
do
export LISTNUM;



	
echo 
echo -------------------------------------------
echo "RUN query/P$LISTNUM.sql start"
echo -------------------------------------------
echo 
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
echo
echo echo "$TPCH_SEC sec"
echo
echo -------------------------------------------
echo "RUN query/P$LISTNUM.sql end"
echo -------------------------------------------
echo 
echo
    cd ..
done

echo
echo -------------------------------------------
echo "RUN POWER END"
echo -------------------------------------------
echo

echo -------------------------------------------
echo "RF2(rf2.sh 1) START"
echo -------------------------------------------
sh rf2.sh 1
echo -------------------------------------------
echo "RF2(rf2.sh 1) END"
echo -------------------------------------------

#Save RF1, RF2 Time for PowerTest
cat ./outfile/RF1_1.out | grep "elapsed time" | awk '{print $4}' >> $QPHH/runP.log
cat ./outfile/RF2_1.out | grep "elapsed time" | awk '{print $4}' >> $QPHH/runP.log

#EXECUTE TPC-H THROUGHPUT QUERY
echo "Throughput Test Start : `date +%Y-%m-%d\ %H:%M:%S`"

thstart=$(date +%s%N)



echo
echo -------------------------------------------
echo "RUN THROUGHOUT TEST START"
echo -------------------------------------------
echo
sh throughput.sh $SEEDNUM
echo
echo -------------------------------------------
echo "RUN THROUGHOUT TEST END"
echo -------------------------------------------
echo

thend=$(date +%s%N)

elapsed=`echo "($thend - $thstart) / 1000000" | bc`
elapsedTime=`echo "scale=2;$elapsed / 1000" | bc`
echo $elapsedTime > $QPHH/runT.log

echo "Throughput Test End : `date +%Y-%m-%d\ %H:%M:%S`"

#Calculate QphH
cd $QPHH; sh final.sh > result.log; cat result.log
