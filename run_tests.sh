#!/bin/sh

# jenkins workspace directory
BASE=$(pwd) # /var/lib/jenkins/workspace/<project_name>
ERIGON_DIR=$BASE/erigon_replay

PORT=8548 # reserved rpcdaemon port

# DATADIR="/mnt/nvme/data1" # chaindata dir
DATADIR="/mnt/rd0_0/goerli" # chaindata dir

LOGS_DIR="/home/kairat/erigon_logs"

LAST_RAPLAY=$(cat last_replay.txt)

RESULTS_DIR=$LOGS_DIR/$LAST_RAPLAY


echo $RESULTS_DIR

# count=0

# while true; do
#     echo "current count: $count"
#     sleep 1
#     count=`expr $count + 1`

#     if [ $count -ge 10 ]; then 
#         echo "Reaced 10"
#         exit 1
#     fi
# done
# echo "current count: $count"

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

replay_files() {
    # $1 - dir with files
    # $2 - port for geth or oe
    if [ -d "$1" ]; then
        echo "Replaying files from $1"
        cd $1

        for eachfile in *.txt; do
            echo "Replaying file $eachfile"

            temp_file=$RESULTS_DIR/_temp.txt

            # redirect output to temp file
            nohup $ERIGON_DIR/build/bin/rpctest replay --erigonUrl http://localhost:$2 --recordFile $eachfile >$temp_file 2>$temp_file &

            wait $!      # wait untill last executed process finishes
            exit_code=$? # grab the code

            echo $exit_code >>$RESULTS_DIR/$eachfile

            tail -n 20 $temp_file >>$RESULTS_DIR/$eachfile

            rm $temp_file

        done

    fi
}

# replay_files $BASE/queries $RPCDAEMONPORT
