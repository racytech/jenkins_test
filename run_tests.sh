#!/bin/sh

BASE=$(pwd)

count=0

while true; do
    echo "current count: $count"
    sleep 1
    count=`expr $count + 1`

    if [ $count -ge 10 ]; then 
        echo "Reaced 10"
        exit 1
    fi
done
echo "current count: $count"


echo "it is a test script"