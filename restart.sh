#!/bin/sh

pid=$(ps aux | grep ./build/bin/erigon | grep datadir | awk '{print $2}')

if [ -z "$pid" ]; then
    echo "Erigon process is not running, so not killing..."
else
    echo "Found erigon process... PID=$pid"
    # kill $pid

    # until [ -z "$pid" ]; do
    #     echo "Waiting for erigon to shut down..."
    #     sleep 1
    #     pid=$(ps aux | grep ./build/bin/erigon | grep datadir | awk '{print $2}')
    # done
fi