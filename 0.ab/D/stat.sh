clear
. /data/strategy/SHARD/DN1/conf/altibase_user.env
echo 
echo 
echo 
echo 
echo DN1 - 20301 
echo 
is -port 20301 -f stat.sql
sleep 1
clear
echo 
echo 
echo DN2 - 20302
echo
is -port 20302 -f stat.sql
sleep 1
clear
echo 
echo 
echo DN3 - 20303
echo
is -port 20303 -f stat.sql
