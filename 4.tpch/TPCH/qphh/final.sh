Power=`qphh 1 $SCALE`
Throughput=`qphh 2 $SCALE $STREAM`
QphH=`qphh 3 $Power $Throughput`

echo "TPC-H Power@Size     " $Power;
echo "TPC-H Throughput@Size" $Throughput;
echo "TPC-H QphH@Size      " $QphH;
