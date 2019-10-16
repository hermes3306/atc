#!/bin/bash

for i in 0 1 2 3 4 
do
	cp DB$i.properties DB$i/conf/altibase.properties
done
