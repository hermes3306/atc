#!/bin/bash

ALTIBASE_HOME=/home/pi/ab72;export ALTIBASE_HOME
PATH=${ALTIBASE_HOME}/bin:${PATH};export PATH
LD_LIBRARY_PATH=${ALTIBASE_HOME}/lib:${LD_LIBRARY_PATH};export LD_LIBRARY_PATH
CLASSPATH=${ALTIBASE_HOME}/lib/Altibase.jar:${CLASSPATH};export CLASSPATH

server restart

