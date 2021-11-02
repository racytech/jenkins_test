#!/bin/sh

BASE=$(pwd) 
ERIGON_DIR=$BASE/erigon_replay
WEB_DIR=$BASE/web
RPCTEST_RESULTS_DIR=$WEB_DIR/rpctest_results
RESULTS_DIR_NAME="replay$(date +%Y%m%d_%H%M%S)"
RESULTS_DIR=$RPCTEST_RESULTS_DIR/$RESULTS_DIR_NAME

echo "it is a build script"
