#!/bin/sh

BASE=$(pwd) 
ERIGON_DIR=$BASE/erigon_replay
WEB_DIR=$BASE/web
RPCTEST_RESULTS_DIR=$WEB_DIR/rpctest_results
RESULTS_DIR_NAME="replay$(date +%Y%m%d_%H%M%S)"
RESULTS_DIR=$RPCTEST_RESULTS_DIR/$RESULTS_DIR_NAME

ERIGONREPO="https://github.com/ledgerwatch/erigon.git"
# BRANCH=$1
HASH="HEAD"

DATADIR="/mnt/nvme/data1"

RPCDAEMONPORT=8548

for i in "$@"; do
    case $i in
    -b=* | --branch=*)
        BRANCH="${i#*=}"
        shift
        ;;
    esac
done

echo "it is a build script and branch is $BRANCH"
