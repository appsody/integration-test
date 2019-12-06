#!/bin/bash

# clone the stacks and appsody repos
# build the appsody binary
mkdir -p $HOME/bats_temp/temp/src/github.com/appsody
mkdir -p $HOME/bats_temp/logs/appsodymaster
mkdir -p $HOME/bats_temp/temp/appsodymaster

export GOPATH=$HOME/bats_temp/temp
export TEMPDIR=$HOME/bats_temp/temp/appsodymaster
export LOGDIR=$HOME/bats_temp/logs/appsodymaster

cd $HOME/bats_temp/temp/src/github.com/appsody
#echo "#### Cloning stacks repo ####"
git clone --quiet https://github.com/appsody/stacks.git
cd stacks
git rev-parse HEAD > $HOME/bats_temp/logs/appsodymaster/git-commit-hash-stacks.log
cd - > /dev/null
#echo "#### Cloning appsody repo ####"
git clone --quiet https://github.com/appsody/appsody.git
cd appsody
git rev-parse HEAD > $HOME/bats_temp/logs/appsodymaster/git-commit-hash-appsody.log
#echo "#### Building appsody binary ####"
make build-darwin > /dev/null

export APPSODY=$HOME/bats_temp/temp/src/github.com/appsody/appsody/build/appsody-0.0.0-darwin-amd64

mkdir $TEMPDIR/nodejs
cd $TEMPDIR/nodejs
#run timeout 1h $APPSODY init dev.local/nodejs
timeout 1h $APPSODY init -v nodejs &> $LOGDIR/integration-good-path-appsody-init-nodejs.log
setsid $APPSODY run -v &> $LOGDIR/integration-good-path-appsody-run2-nodejs.log &
# sleep to let the container come up then capture the container id
sleep 10
CONTAINER=$($APPSODY ps | awk 'NR==2{print $1}')
echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run2-nodejs-ps-before-kill.log

# stop the running container
# kill -2 to the groupid simulates a "CTRL-C"
PID=$(ps xao pgid,command | grep '[a]ppsody.* run' | awk '{print $1}')
echo $PID > $LOGDIR/integration-good-path-appsody-run2-nodejs-PID.log
kill -2 -$PID   

# sleep to let the stop process complete
sleep 11    

# verify there are no running containers
# nothing should be logged if there are no running containers
CONTAINER2=$(appsody ps | awk 'NR==2{print $1}')
echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run2-nodejs-ps-after-kill.log
#run $APPSODY ps
$APPSODY ps