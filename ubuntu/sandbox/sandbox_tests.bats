load sandbox_helper
teardown() {
  if [[ "${#BATS_TEST_NAMES[@]}" -eq "$BATS_TEST_NUMBER" ]]; then
    rm -rf $GOPATH
  fi
}

# nodejs-express
@test "integration-good-path-appsody-stack-validate-nodejs-express" {
    # validate
    cd $TEMPDIR/stacks/incubator/nodejs-express
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stack-validate-nodejs-express.log
    [ "$status" -eq 0 ]
}

# node-red
@test "integration-good-path-appsody-stack-validate-node-red" {
    # validate
    cd $TEMPDIR/stacks/incubator/node-red
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stack-validate-node-red.log
    [ "$status" -eq 0 ]
}

# java-spring-boot2
@test "integration-good-path-appsody-stack-validate-java-spring-boot2" {
    # validate
    cd $TEMPDIR/stacks/incubator/java-spring-boot2
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stack-validate-java-spring-boot2.log
    [ "$status" -eq 0 ]
}

# python-flask
@test "integration-good-path-appsody-stack-validate-python-flask" {
    # validate
    cd $TEMPDIR/stacks/incubator/python-flask
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stack-validate-python-flask.log
    [ "$status" -eq 0 ]
}

@test "integration-good-path-appsody-init-python-flask" {
    # init
    mkdir -p $TEMPDIR/python-flask
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY init -v dev.local/python-flask
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-python-flask.log
    [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-run-python-flask" {
    # run
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY run -v &
    echo "${output}" > $LOGDIR/integration-good-path-appsody-run.log 
}
@test "integration-good-path-appsody-stop-python-flask" {
    # stop

    # sleep to let the container come up then capture the container id
    sleep 300
    CONTAINER=$($APPSODY ps | awk 'NR==2{print $2}')
    echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run-python-flask-ps-before-stop.log

    # stop the container
    run timeout 1m $APPSODY stop -v --name $CONTAINER
    echo "${output}"
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stop-python-flask.log
    [ "$status" -eq 0 ]

    # verify no running containers
    CONTAINER2=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run-python-flask-ps-after-kill.log
    run timeout 1m $APPSODY ps
    [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]

}

@test "integration-good-path-appsody-run2-python-flask" {
    # run
    # not able to log output from "appsody run &" due to the "&"
    cd $TEMPDIR/python-flask
    setsid $APPSODY run -v &> $LOGDIR/integration-good-path-appsody-run2-python-flask.log &

    # sleep to let the container come up then capture the container id
    sleep 300
    CONTAINER=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run2-python-flask-ps-before-kill.log
}
@test "integration-good-path-appsody-ctrl-c-python-flask" {
    # stop the running container
    # kill -2 to the groupid simulates a "CTRL-C"
    # need the [a]ppsody.* run to be sure we get the correct appsody binary
    PID=$(ps xao pgid,command | grep '[a]ppsody.* run' | awk '{print $1}')
    echo $PID > $LOGDIR/integration-good-path-appsody-run2-python-flask-PID.log
    kill -2 -$PID   

    # sleep to let the stop process complete
    sleep 11    

    # verify there are no running containers
    # nothing should be logged if there are no running containers
    CONTAINER2=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run2-python-flask-ps-after-kill.log
    run $APPSODY ps
    [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]
}

# starter
@test "integration-good-path-appsody-stack-validate-starter" {
    # validate
    cd $TEMPDIR/stacks/incubator/starter
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stack-validate-starter.log
    [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-init-starter" {
    # init
    mkdir -p $TEMPDIR/starter
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY init -v dev.local/starter
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-starter.log
    [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-run-starter" {
    # run
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY run -v &
    echo "${output}" > $LOGDIR/integration-good-path-appsody-run.log 
}
@test "integration-good-path-appsody-stop-starter" {
    # stop

    # sleep to let the container come up then capture the container id
    sleep 300
    CONTAINER=$($APPSODY ps | awk 'NR==2{print $2}')
    echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run-starter-ps-before-stop.log

    # stop the container
    run timeout 1m $APPSODY stop -v --name $CONTAINER
    echo "${output}"
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stop-starter.log
    [ "$status" -eq 0 ]

    # verify no running containers
    CONTAINER2=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run-starter-ps-after-kill.log
    run timeout 1m $APPSODY ps
    [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]

}

@test "integration-good-path-appsody-run2-starter" {
    # run
    # not able to log output from "appsody run &" due to the "&"
    cd $TEMPDIR/starter
    setsid $APPSODY run -v &> $LOGDIR/integration-good-path-appsody-run2-starter.log &

    # sleep to let the container come up then capture the container id
    sleep 300
    CONTAINER=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run2-starter-ps-before-kill.log
}
@test "integration-good-path-appsody-ctrl-c-starter" {
    # stop the running container
    # kill -2 to the groupid simulates a "CTRL-C"
    # need the [a]ppsody.* run to be sure we get the correct appsody binary
    PID=$(ps xao pgid,command | grep '[a]ppsody.* run' | awk '{print $1}')
    echo $PID > $LOGDIR/integration-good-path-appsody-run2-starter-PID.log
    kill -2 -$PID   

    # sleep to let the stop process complete
    sleep 11    

    # verify there are no running containers
    # nothing should be logged if there are no running containers
    CONTAINER2=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run2-starter-ps-after-kill.log
    run $APPSODY ps
    [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]
}