#!/bin/sh

BASE=$(pwd)

for i in "$@"; do
    case $i in
    -bid=* | --buildid=*)
        BUILD_ID="${i#*=}"
        shift
        ;;
    esac
done


echo "it is a deploy script"
echo "$BUILD_ID"