#!/bin/bash
# if check for creating a date-stamped log directory
# to store all log files for all the @test in the bats file
if [ -z "$LOGDIR" ]; then
    mkdir -p $HOME/bats_temp/logs/$(date +%Y%m%d_%H%M%S)
    export LOGDIR=$HOME/bats_temp/logs/$(date +%Y%m%d_%H%M%S)
fi
# if check for creating the 
if [ -z "$APPSODY" ]; then
    mkdir -p $HOME/bats_temp/temp/src/github.com/appsody
    export TEMPDIR=$HOME/bats_temp/temp/src/github.com/appsody
    export GOPATH=$HOME/bats_temp/temp
    cd $HOME/bats_temp/temp/src/github.com/appsody
    echo "#### Cloning stacks repo ####"
    git clone https://github.com/appsody/stacks.git
    echo "#### Cloning appsody repo ####"
    git clone https://github.com/appsody/appsody.git
    cd appsody
    echo "#### Building appsody binary ####"
    make build-linux
    export APPSODY=$TEMPDIR/appsody/build/appsody-0.0.0-linux-amd64
fi
