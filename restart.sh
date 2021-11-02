#!/bin/sh

BASE=$(pwd)
ERIGON_DIR=$BASE/erigon_replay

erigon_pid=$(ps aux | grep ./build/bin/erigon | grep datadir | awk '{print $2}')

if [ -z "$erigon_pid" ]; then
    echo "Erigon process is not running... we good to go."
else
    echo "Found erigon process... PID=$erigon_pid"
    echo "Sending SIGTERM signal to PID=$erigon_pid"
    # kill $erigon_pid

    # until [ -z "$erigon_pid" ]; do
    #     echo "Waiting for erigon to shut down..."
    #     sleep 1
    #     erigon_pid=$(ps aux | grep ./build/bin/erigon | grep datadir | awk '{print $2}')
    # done
fi

cd $ERIGON_DIR

ls