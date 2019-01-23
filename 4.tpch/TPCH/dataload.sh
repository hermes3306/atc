cd $TPCH_HOME/data
rm -f *.log
rm -f *.bad
echo "$SCALE Data Load Start"
sh load.sh
echo "$SCALE Load End"
