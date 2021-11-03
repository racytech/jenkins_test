#!/bin/sh

# jenkins workspace directory
BASE=$(pwd) # /var/lib/jenkins/workspace/<project_name>
ERIGON_DIR=$BASE/erigon_replay

PORT=8548 # reserved rpcdaemon port

# DATADIR="/mnt/nvme/data1" # chaindata dir
DATADIR="/mnt/rd0_0/goerli" # chaindata dir

LOGS_DIR="/home/kairat/erigon_logs"
RESULTS_DIR_NAME="replay$(date +%Y%m%d_%H%M%S)"
RESULTS_DIR=$LOGS_DIR/$RESULTS_DIR_NAME

erigon_pid=$(ps aux | grep ./build/bin/erigon | grep datadir | awk '{print $2}')
# if erigon is running send SIGTERM
if [ -z "$erigon_pid" ]; then
    echo "Erigon process is not running... we good to go."
else
    echo "Found erigon process... PID=$erigon_pid"
    echo "Sending SIGTERM signal to PID=$erigon_pid"
    kill $erigon_pid

    until [ -z "$erigon_pid" ]; do
        echo "Waiting for erigon to stop..."
        sleep 1
        erigon_pid=$(ps aux | grep ./build/bin/erigon | grep datadir | awk '{print $2}')
    done
fi


# rpcdaemon_pid=$(ps aux | grep $1 | grep $2 | awk '{print $2}')
rpcdaemon_pid=$(lsof -n -i :$PORT | grep LISTEN | awk '{print $2}')
# kill any process running on port reserved for rpcdaemon
if [ ! -z "$rpcdaemon_pid" ]; then
    echo "Found process listening on reserved port $PORT. PID=$rpcdaemon_pid"
    echo "Sending SIGTERM signal to PID=$rpcdaemon_pid"
    kill $rpcdaemon_pid

    pid=$rpcdaemon_pid
    until [ -z "$pid" ]; do
        echo "Waiting for process to stop..."
        sleep 1
        pid=$(lsof -n -i :$PORT | grep LISTEN | awk '{print $2}')
    done
else
    echo "There is no process listening on reserved port $PORT (rpcdaemon port)..."
fi

limit_lines() {

    # limits redirected output lines to arg $3
    # usage example:
    # command_that_continuously_outputs | limit_lines "file_to_write" "file_helper" "number_of_lines_limit"

    file_name=$1
    file_out=$2
    limit=$3

    touch $file_name
    touch $file_out

    while IFS='' read -r line; do
        line_count=$(wc -l <"$file_name")
        if [ $line_count -gt $limit ]; then
            sed 1d $file_name >$file_out
            {
                cat $file_out
                printf '%s\n' "$line"
            } >$file_name
        else
            echo $line >>$file_name
        fi
    done
}

mkdir -p $RESULTS_DIR

nohup ./build/bin/erigon --datadir $DATADIR --chain goerli --private.api.addr=localhost:9090 2>&1 | $(limit_lines "$RESULTS_DIR/erigon.log" "$RESULTS_DIR/_erigon.log" "20") &
nohup ./build/bin/rpcdaemon --private.api.addr=localhost:9090 --http.port=$PORT --http.api=eth,erigon,web3,net,debug,trace,txpool --verbosity=4 --datadir "$DATADIR" 2>&1 | $(limit_lines "$RESULTS_DIR/rpcdaemon.log" "$RESULTS_DIR/_rpcdaemon.log" "20") &