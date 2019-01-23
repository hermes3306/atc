#!/bin/sh

. ./set_test.env

export SCALE=1

#DB CLEAN
sh clean.sh

#CREATE SCHEMA
isql -s $HOST -u $DBUSER -p $DBPASS -port $PORT -f schema.sql -o ./log/schema.out

#CREATE DATA
sh create_data.sh

#DATA LOADING
cd $TPCH_HOME
sh dataload.sh

#CREATE INDEX & CREATE STATISTICS INFO
isql -s $HOST -u $DBUSER -p $DBPASS -port $PORT -f index.sql -o ./log/index.out
isql -s $HOST -u $DBUSER -p $DBPASS -port $PORT -f stats.sql -o ./log/stats.out

#EXECUTE TPC-H QUERY
rm -f ./outfile/*.out

QLIST="14 2 9 20 6 17 18 8 21 13 3 22 16 4 11 15 1 10 19 5 7 12"

for LISTNUM in $QLIST
do
export LISTNUM;
    isql -s $HOST -u $DBUSER -p $DBPASS -port $PORT -silent -f query/Q$LISTNUM.sql -o outfile/Q$LISTNUM.out
done

sh validate.sh
