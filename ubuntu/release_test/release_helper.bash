#!/bin/bash
# function to setup the test environment
function setupenv() {
    # write the date in to the file
    DATE=$(date +%Y%m%d_%H%M%S)
    mkdir -p $HOME/bats_temp/logs/$DATE
    echo $DATE > $DATEFILE
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
export APPSODY=$TEMPDIR/appsody/build/appsody-0.0.0-darwin-amd64 
