#!/bin/bash
mkdir -p $HOME/bats_temp/logs/appsody502
mkdir -p $HOME/bats_temp/temp/appsody502
export TEMPDIR=$HOME/bats_temp/temp/appsody502
export LOGDIR=$HOME/bats_temp/logs/appsody502

mkdir $TEMPDIR/nodejs
cd $TEMPDIR/nodejs
#run timeout 1h $APPSODY init dev.local/nodejs
timeout 1h appsody init nodejs > $LOGDIR/integration-good-path-appsody-init-nodejs.log
setsid appsody run > $LOGDIR/integration-good-path-appsody-run2-nodejs.log &
# sleep to let the container come up then capture the container id
sleep 10
CONTAINER=$(appsody ps | awk 'NR==2{print $1}')
echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run2-nodejs-ps-before-kill.log

# stop the running container
# kill -2 to the groupid simulates a "CTRL-C"
PID=$(ps xao pgid,command | grep '[a]ppsody run' | awk '{print $1}')
echo $PID > $LOGDIR/integration-good-path-appsody-run2-nodejs-PID.log
kill -2 -$PID   

# sleep to let the stop process complete
sleep 11    

# verify there are no running containers
# nothing should be logged if there are no running containers
CONTAINER2=$(appsody ps | awk 'NR==2{print $1}')
echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run2-nodejs-ps-after-kill.log
#run $APPSODY ps
appsody ps