#!/bin/bash
# if check for creating a date-stamped log directory
# to store all log files for all the @test in the bats file
FILE=$HOME/bats_temp/logs/datefile
if [ -f "$FILE" ]; then
    LINE=$(head -n 1 $FILE)
else
    # write the date in to the file
    LINE=$(date +%Y%m%d_%H%M%S)
    mkdir -p $HOME/bats_temp/logs/$LINE
    echo $LINE > $FILE

    # clone the stacks and appsody repos
    # build the appsody binary
    mkdir -p $HOME/bats_temp/temp/src/github.com/appsody
    export GOPATH=$HOME/bats_temp/temp
    cd $HOME/bats_temp/temp/src/github.com/appsody
    echo "#### Cloning stacks repo ####"
    git clone https://github.com/appsody/stacks.git
    echo "#### Cloning appsody repo ####"
    git clone https://github.com/appsody/appsody.git
    cd appsody
    echo "#### Building appsody binary ####"
    make build-windows
fi

# exports for use with the tests
export FILE
export GOPATH=$HOME/bats_temp/temp
export LOGDIR=$HOME/bats_temp/logs/$LINE
export TEMPDIR=$HOME/bats_temp/temp/src/github.com/appsody
export APPSODY=$TEMPDIR/appsody/build/appsody-0.0.0-windows-amd64.exe
