#!/bin/bash
# function to setup the test environment
function setupenv() {
    # write the date in to the file
    DATE=$(date +%Y%m%d_%H%M%S)
    mkdir -p $HOME/bats_temp/logs/$DATE
    echo $DATE > $DATEFILE

    # clone the stacks and appsody repos
    # build the appsody binary
    mkdir -p $HOME/bats_temp/temp/src/github.com/appsody
    export GOPATH=$HOME/bats_temp/temp
    cd $HOME/bats_temp/temp/src/github.com/appsody
    #echo "#### Cloning stacks repo ####"
    git clone --quiet https://github.com/appsody/stacks.git
    cd stacks
    git reset --hard ae1b2087e0601790f642c6894ef8b8c1c9f326e2
    git rev-parse HEAD > $HOME/bats_temp/logs/$DATE/git-commit-hash-stacks.log
    cd - > /dev/null
    #echo "#### Cloning appsody repo ####"
    git clone --quiet https://github.com/appsody/appsody.git
    cd appsody
    git reset --hard 76152db9d4481f4ed27f9b3d60e0f44bdae5aabc
    git rev-parse HEAD > $HOME/bats_temp/logs/$DATE/git-commit-hash-appsody.log
    #echo "#### Building appsody binary ####"
    # make build-darwin > /dev/null
    make build-linux > /dev/null
    # make build-windows
}

# variables for the log datafile and the temp setup directory
DATEFILE=$HOME/bats_temp/logs/datefile
SETUPDIR=$HOME/bats_temp/temp/

# if check for the log datefile
# if the file exists set the date to the first line of the file
# else run setupenv
if [ -f "$DATEFILE" ]; then
    DATE=$(head -n 1 $DATEFILE)
else
    setupenv
fi

# if check for setup directory
# if is doesn't exist run setupenv
if [ ! -d "$SETUPDIR" ]; then
    setupenv
fi

# exports for use with the tests
export DATEFILE
export GOPATH=$HOME/bats_temp/temp
export LOGDIR=$HOME/bats_temp/logs/$DATE
export TEMPDIR=$HOME/bats_temp/temp/src/github.com/appsody
# export APPSODY=$TEMPDIR/appsody/build/appsody-0.0.0-darwin-amd64 
export APPSODY=$TEMPDIR/appsody/build/appsody-0.0.0-linux-amd64
# export APPSODY=$TEMPDIR/appsody/build/appsody-0.0.0-windows-amd64.exe

# set APPSODY to appsody if testing the locally built binary (release test)
# export APPSODY=appsody
