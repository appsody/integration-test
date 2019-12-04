#!/usr/bin/env bats
load kim_helper

teardown() {
  if [[ "${#BATS_TEST_NAMES[@]}" -eq "$BATS_TEST_NUMBER" ]]; then
    rm -rf $GOPATH
  fi
}

@test "good path test appsody run nodejs" {
    # WARNING: this test is not returning pass/fail status due 
    # to the "&" in "appsody run &" so any test after this 
    # test will not be run

    # init
    mkdir -p $TEMPDIR/nodejs
    cd $TEMPDIR/nodejs
    run appsody init nodejs
    echo "${output}"
    echo "${output}" > $LOGDIR/good-path-appsody-init-nodejs.log
    [ "$status" -eq 0 ]

    # run
    # not able to log output from "appsody run &" due to the "&"
    setsid appsody run &

    # sleep to let the container come up then capture the container id
    sleep 10
    CONTAINER=$(appsody ps | awk 'NR==2{print $1}')
    echo $CONTAINER > $LOGDIR/good-path-appsody-run-nodejs-ps-before-kill.log

    # stop the running container
    # kill -2 to the groupid simulates a "CTRL-C"
    PID=$(ps xao pgid,command | grep '[a]ppsody run' | awk '{print $1}')
    echo $PID > $LOGDIR/good-path-appsody-run-nodejs-PID.log
    kill -2 -$PID
   

    # sleep to let the stop process complete
    sleep 11
    

    # verify there are no running containers
    # nothing should be logged if there are no running containers
    CONTAINER2=$(appsody ps | awk 'NR==2{print $1}')
    echo $CONTAINER2 > $LOGDIR/good-path-appsody-run-nodejs-ps-after-kill.log
    run appsody ps
    [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]
}
