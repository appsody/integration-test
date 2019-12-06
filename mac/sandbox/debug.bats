load debug_helper
teardown() {
  if [[ "${#BATS_TEST_NAMES[@]}" -eq "$BATS_TEST_NUMBER" ]]; then
    rm -rf $GOPATH
  fi
}
# nodejs
@test "integration-good-path-appsody-init-nodejs" {
    # init
    mkdir -p $TEMPDIR/nodejs
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY init -v dev.local/nodejs
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-nodejs.log
    [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-run2-nodejs" {
    # run
    # not able to log output from "appsody run &" due to the "&"
    cd $TEMPDIR/nodejs
    setsid $APPSODY run -v &> $LOGDIR/integration-good-path-appsody-run2-nodejs.log &

    # sleep to let the container come up then capture the container id
    sleep 10

    CONTAINER=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run2-nodejs-ps-before-kill.log
}
@test "integration-good-path-appsody-ctrl-c-nodejs" {
    # stop the running container
    # kill -2 to the groupid simulates a "CTRL-C"
    PID=$(ps xao pgid,command | grep '[a]ppsody.* run' | awk '{print $1}')
    echo $PID > $LOGDIR/integration-good-path-appsody-run2-nodejs-PID.log
    kill -2 -$PID   

    # sleep to let the stop process complete
    sleep 11    

    # verify there are no running containers
    # nothing should be logged if there are no running containers
    CONTAINER2=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run2-nodejs-ps-after-kill.log
    run $APPSODY ps
    [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]
}