ALTIBASE_HOME=/home/pi/AB631
javac -cp .:$ALTIBASE_HOME/lib/Altibase5.jar:$ALTIBASE_HOME/lib/Altibase.jar *.java
java  -cp .:$ALTIBASE_HOME/lib/Altibase5.jar:$ALTIBASE_HOME/lib/Altibase.jar jdbctest


