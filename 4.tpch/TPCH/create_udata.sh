#!/bin/sh

export UCOUNT=`expr $STREAM + 1`
cd $DBGEN_HOME
./dbgen -v -s $SCALE -U $UCOUNT

rm -f $TPCH_HOME/RF/*.tbl.*
rm -f $TPCH_HOME/RF/delete.*

mv -f *.tbl.* $TPCH_HOME/RF
mv -f delete.* $TPCH_HOME/RF
