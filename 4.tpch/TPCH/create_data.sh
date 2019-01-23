#!/bin/sh

rm -f $TPCH_HOME/data/*.tbl*

cd $DBGEN_HOME
rm -f *.tbl*

if [ $SCALE -le 30 ]
then
    ./dbgen -v -s $SCALE
else
    ./dbgen -v -s $SCALE -T l
    for i in `seq 1 $SPCINT`
    do
        ./dbgen -v -s $SCALE -S $i -C $SPCOUNT -T c
        ./dbgen -v -s $SCALE -S $i -C $SPCOUNT -T p
        ./dbgen -v -s $SCALE -S $i -C $SPCOUNT -T s
        ./dbgen -v -s $SCALE -S $i -C $SPCOUNT -T o
    done
fi

mv -f *.tbl* $TPCH_HOME/data
