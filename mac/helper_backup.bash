#!/bin/bash
# if check for creating a date-stamped log directory
# to store all log files for all the @test in the bats file
if [ -z "$LOGDIR" ]; then
    mkdir $HOME/bats_temp/logs/$(date +%Y%m%d_%H%M%S)
    export LOGDIR=$HOME/bats_temp/logs/$(date +%Y%m%d_%H%M%S)
fi
# if check for creating the 
if [ -z "$APPSODY" ]; then
    mkdir -p $HOME/bats_temp/temp
    cd $HOME/bats_temp/temp
    git clone https://github.com/appsody/stacks.git
    git clone https://github.com/appsody/appsody.git
    cd appsody
    make build
    export APPSODY=$HOME/bats_temp/temp/appsody/build/appsody-0.0.0-darwin-amd64
    export TEMPDIR=$HOME/bats_temp/temp
fi
