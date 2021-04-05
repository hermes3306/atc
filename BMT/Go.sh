#!/bin/sh

HOST="localhost"
PORT="20300"
CONNTYPE="1"

THREADS="1"
RECORDS="100000"
UNIT="1000"
THRESHOLD="1000"
CAP="0"
USER="SYS"
PASSWORD="MANAGER"
OPTION="DSN=$HOST;PORT_NO=$PORT;CONNTYPE=$CONNTYPE"

./configure.sh
make clean
make
echo

case $CONNTYPE in
    "1" )
        export ISQL_CONNECTION="TCP"
        ;;
    "2" )
        export ISQL_CONNECTION="UNIX"
        ;;
    "3" )
        export ISQL_CONNECTION="IPC"
        ;;
esac
isql -s $HOST -u $USER -p $PASSWORD -port $PORT -f schema.sql
echo

echo "################# THREAD 1 #########################"
echo "################# THREAD 1 #########################"
echo "################# THREAD 1 #########################"
echo "################# THREAD 1 #########################"
echo "################# THREAD 1 #########################"

START="0"
for THREAD in $THREADS
do
isql -s $HOST -u $USER -p $PASSWORD -port $PORT -f checkpoint.sql
./bmt_insert $THREAD $START $RECORDS $UNIT $THRESHOLD $CAP $USER $PASSWORD $OPTION
START=`expr $START + $RECORDS`
done

START="0"
for THREAD in $THREADS
do
isql -s $HOST -u $USER -p $PASSWORD -port $PORT -f checkpoint.sql
./bmt_select $THREAD $START $RECORDS $UNIT $THRESHOLD $CAP $USER $PASSWORD $OPTION
START=`expr $START + $RECORDS`
done

START="0"
for THREAD in $THREADS
do
isql -s $HOST -u $USER -p $PASSWORD -port $PORT -f checkpoint.sql
./bmt_update $THREAD $START $RECORDS $UNIT $THRESHOLD $CAP $USER $PASSWORD $OPTION
START=`expr $START + $RECORDS`
done

START="0"
for THREAD in $THREADS
do
isql -s $HOST -u $USER -p $PASSWORD -port $PORT -f checkpoint.sql
./bmt_delete $THREAD $START $RECORDS $UNIT $THRESHOLD $CAP $USER $PASSWORD $OPTION
START=`expr $START + $RECORDS`
done

THREADS="16"
echo "################# THREAD 16 #########################"
echo "################# THREAD 16 #########################"
echo "################# THREAD 16 #########################"
echo "################# THREAD 16 #########################"
echo "################# THREAD 16 #########################"

START="0"
for THREAD in $THREADS
do
isql -s $HOST -u $USER -p $PASSWORD -port $PORT -f checkpoint.sql
./bmt_insert $THREAD $START $RECORDS $UNIT $THRESHOLD $CAP $USER $PASSWORD $OPTION
START=`expr $START + $RECORDS`
done

START="0"
for THREAD in $THREADS
do
isql -s $HOST -u $USER -p $PASSWORD -port $PORT -f checkpoint.sql
./bmt_select $THREAD $START $RECORDS $UNIT $THRESHOLD $CAP $USER $PASSWORD $OPTION
START=`expr $START + $RECORDS`
done

START="0"
for THREAD in $THREADS
do
isql -s $HOST -u $USER -p $PASSWORD -port $PORT -f checkpoint.sql
./bmt_update $THREAD $START $RECORDS $UNIT $THRESHOLD $CAP $USER $PASSWORD $OPTION
START=`expr $START + $RECORDS`
done

START="0"
for THREAD in $THREADS
do
isql -s $HOST -u $USER -p $PASSWORD -port $PORT -f checkpoint.sql
./bmt_delete $THREAD $START $RECORDS $UNIT $THRESHOLD $CAP $USER $PASSWORD $OPTION
START=`expr $START + $RECORDS`
done
