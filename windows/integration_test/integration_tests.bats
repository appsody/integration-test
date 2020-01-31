load integration_helper
teardown() {
  if [[ "${#BATS_TEST_NAMES[@]}" -eq "$BATS_TEST_NUMBER" ]]; then
    rm -rf $GOPATH
  fi
}
# nodejs
@test "integration-good-path-appsody-stack-validate-nodejs" {
    # validate
    cd $TEMPDIR/stacks/incubator/nodejs
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stack-validate-nodejs.log
    [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-init-nodejs" {
    # init
    mkdir -p $TEMPDIR/nodejs
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY init -v dev.local/nodejs
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-nodejs.log
    [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-run-nodejs" {
    # run
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY run -v &
    echo "${output}" > $LOGDIR/integration-good-path-appsody-run-nodejs.log 
}
@test "integration-good-path-appsody-stop-nodejs" {
    # stop

    # sleep to let the container come up then capture the container id
    sleep 300
    CONTAINER=$($APPSODY ps | awk 'NR==2{print $2}')
    echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run-nodejs-ps-before-stop.log

    # stop the container
    run timeout 1m $APPSODY stop -v --name $CONTAINER
    echo "${output}"
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stop-nodejs.log
    [ "$status" -eq 0 ]

    # verify no running containers
    CONTAINER2=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run-nodejs-ps-after-kill.log
    run timeout 1m $APPSODY ps
    [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]

@test "integration-good-path-appsody-operator-install-nodejs" {
    # operator install
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator install --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-operator-install-nodejs.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-nodejs" {
    # deploy
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy --tag $TAG --pull-url $PULLURL --push-url $PUSHURL --push --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-nodejs.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-delete-nodejs" {
    # deploy delete
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy delete --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-delete-nodejs.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-operator-uninstall-nodejs" {
    # operator uninstall
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-operator-uninstall-nodejs.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-run2-nodejs" {
    skip
    # run
    # not able to log output from "appsody run &" due to the "&"
    cd $TEMPDIR/nodejs
    setsid $APPSODY run -v &> $LOGDIR/integration-good-path-appsody-run2-nodejs.log &

    # sleep to let the container come up then capture the container id
    sleep 300
    CONTAINER=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run2-nodejs-ps-before-kill.log
}
@test "integration-good-path-appsody-ctrl-c-nodejs" {
    skip
    # stop the running container
    # kill -2 to the groupid simulates a "CTRL-C"
    # need the [a]ppsody.* run to be sure we get the correct appsody binary
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
# nodejs-express
@test "integration-good-path-appsody-stack-validate-nodejs-express" {
    # validate
    cd $TEMPDIR/stacks/incubator/nodejs-express
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stack-validate-nodejs-express.log
    [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-init-nodejs-express" {
    # init
    mkdir -p $TEMPDIR/nodejs-express
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY init -v dev.local/nodejs-express
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-nodejs-express.log
    [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-run-nodejs-express" {
    # run
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY run -v &
    echo "${output}" > $LOGDIR/integration-good-path-appsody-run-nodejs-express.log 
}
@test "integration-good-path-appsody-stop-nodejs-express" {
    # stop

    # sleep to let the container come up then capture the container id
    sleep 300
    CONTAINER=$($APPSODY ps | awk 'NR==2{print $2}')
    echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run-nodejs-express-ps-before-stop.log

    # stop the container
    run timeout 1m $APPSODY stop -v --name $CONTAINER
    echo "${output}"
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stop-nodejs-express.log
    [ "$status" -eq 0 ]

    # verify no running containers
    CONTAINER2=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run-nodejs-express-ps-after-kill.log
    run timeout 1m $APPSODY ps
    [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]

}
@test "integration-good-path-appsody-operator-install-nodejs-express" {
    # operator install
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator install --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-operator-install-nodejs-express.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-nodejs-express" {
    # deploy
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy --tag $TAG --pull-url $PULLURL --push-url $PUSHURL --push --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-nodejs-express.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-delete-nodejs-express" {
    # deploy delete
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy delete --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-delete-nodejs-express.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-operator-uninstall-nodejs-express" {
    # operator uninstall
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-operator-uninstall-nodejs-express.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-run2-nodejs-express" {
    skip
    # run
    # not able to log output from "appsody run &" due to the "&"
    cd $TEMPDIR/nodejs-express
    setsid $APPSODY run -v &> $LOGDIR/integration-good-path-appsody-run2-nodejs-express.log &

    # sleep to let the container come up then capture the container id
    sleep 300
    CONTAINER=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run2-nodejs-express-ps-before-kill.log
}
@test "integration-good-path-appsody-ctrl-c-nodejs-express" {
    skip
    # stop the running container
    # kill -2 to the groupid simulates a "CTRL-C"
    # need the [a]ppsody.* run to be sure we get the correct appsody binary
    PID=$(ps xao pgid,command | grep '[a]ppsody.* run' | awk '{print $1}')
    echo $PID > $LOGDIR/integration-good-path-appsody-run2-nodejs-express-PID.log
    kill -2 -$PID   

    # sleep to let the stop process complete
    sleep 11    

    # verify there are no running containers
    # nothing should be logged if there are no running containers
    CONTAINER2=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run2-nodejs-express-ps-after-kill.log
    run $APPSODY ps
    [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]
}
# nodejs-loopback
@test "integration-good-path-appsody-stack-validate-nodejs-loopback" {
    # validate
    cd $TEMPDIR/stacks/incubator/nodejs-loopback
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stack-validate-nodejs-loopback.log
    [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-init-nodejs-loopback" {
    # init
    mkdir -p $TEMPDIR/nodejs-loopback
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY init -v dev.local/nodejs-loopback
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-nodejs-loopback.log
    [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-run-nodejs-loopback" {
    # run
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY run -v &
    echo "${output}" > $LOGDIR/integration-good-path-appsody-run-nodejs-loopback.log 
}
@test "integration-good-path-appsody-stop-nodejs-loopback" {
    # stop

    # sleep to let the container come up then capture the container id
    sleep 300
    CONTAINER=$($APPSODY ps | awk 'NR==2{print $2}')
    echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run-nodejs-loopback-ps-before-stop.log

    # stop the container
    run timeout 1m $APPSODY stop -v --name $CONTAINER
    echo "${output}"
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stop-nodejs-loopback.log
    [ "$status" -eq 0 ]

    # verify no running containers
    CONTAINER2=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run-nodejs-loopback-ps-after-kill.log
    run timeout 1m $APPSODY ps
    [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]

}
@test "integration-good-path-appsody-operator-install-nodejs-loopback" {
    # operator install
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator install --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-operator-install-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-nodejs-loopback" {
    # deploy
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy --tag $TAG --pull-url $PULLURL --push-url $PUSHURL --push --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-delete-nodejs-loopback" {
    # deploy delete
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy delete --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-delete-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-operator-uninstall-nodejs-loopback" {
    # operator uninstall
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-operator-uninstall-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-run2-nodejs-loopback" {
    skip
    # run
    # not able to log output from "appsody run &" due to the "&"
    cd $TEMPDIR/nodejs-loopback
    setsid $APPSODY run -v &> $LOGDIR/integration-good-path-appsody-run2-nodejs-loopback.log &

    # sleep to let the container come up then capture the container id
    sleep 300
    CONTAINER=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run2-nodejs-loopback-ps-before-kill.log
}
@test "integration-good-path-appsody-ctrl-c-nodejs-loopback" {
    skip
    # stop the running container
    # kill -2 to the groupid simulates a "CTRL-C"
    # need the [a]ppsody.* run to be sure we get the correct appsody binary
    PID=$(ps xao pgid,command | grep '[a]ppsody.* run' | awk '{print $1}')
    echo $PID > $LOGDIR/integration-good-path-appsody-run2-nodejs-loopback-PID.log
    kill -2 -$PID   

    # sleep to let the stop process complete
    sleep 11    

    # verify there are no running containers
    # nothing should be logged if there are no running containers
    CONTAINER2=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run2-nodejs-loopback-ps-after-kill.log
    run $APPSODY ps
    [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]
}
# node-red
@test "integration-good-path-appsody-stack-validate-node-red" {
    # validate
    cd $TEMPDIR/stacks/incubator/node-red
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stack-validate-node-red.log
    [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-init-node-red" {
    # init
    mkdir -p $TEMPDIR/node-red
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY init -v dev.local/node-red
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-node-red.log
    [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-run-node-red" {
    # run
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY run -v &
    echo "${output}" > $LOGDIR/integration-good-path-appsody-run-node-red.log 
}
@test "integration-good-path-appsody-stop-node-red" {
    # stop

    # sleep to let the container come up then capture the container id
    sleep 300
    CONTAINER=$($APPSODY ps | awk 'NR==2{print $2}')
    echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run-node-red-ps-before-stop.log

    # stop the container
    run timeout 1m $APPSODY stop -v --name $CONTAINER
    echo "${output}"
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stop-node-red.log
    [ "$status" -eq 0 ]

    # verify no running containers
    CONTAINER2=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run-node-red-ps-after-kill.log
    run timeout 1m $APPSODY ps
    [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]

}
@test "integration-good-path-appsody-operator-install-node-red" {
    # operator install
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator install --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-operator-install-node-red.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-node-red" {
    # deploy
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy --tag $TAG --pull-url $PULLURL --push-url $PUSHURL --push --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-node-red.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-delete-node-red" {
    # deploy delete
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy delete --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-delete-node-red.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-operator-uninstall-node-red" {
    # operator uninstall
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-operator-uninstall-node-red.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-run2-node-red" {
    skip
    # run
    # not able to log output from "appsody run &" due to the "&"
    cd $TEMPDIR/node-red
    setsid $APPSODY run -v &> $LOGDIR/integration-good-path-appsody-run2-node-red.log &

    # sleep to let the container come up then capture the container id
    sleep 300
    CONTAINER=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run2-node-red-ps-before-kill.log
}
@test "integration-good-path-appsody-ctrl-c-node-red" {
    skip
    # stop the running container
    # kill -2 to the groupid simulates a "CTRL-C"
    # need the [a]ppsody.* run to be sure we get the correct appsody binary
    PID=$(ps xao pgid,command | grep '[a]ppsody.* run' | awk '{print $1}')
    echo $PID > $LOGDIR/integration-good-path-appsody-run2-node-red-PID.log
    kill -2 -$PID   

    # sleep to let the stop process complete
    sleep 11    

    # verify there are no running containers
    # nothing should be logged if there are no running containers
    CONTAINER2=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run2-node-red-ps-after-kill.log
    run $APPSODY ps
    [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]
}
# java-microprofile
@test "integration-good-path-appsody-stack-validate-java-microprofile" {
    # validate
    cd $TEMPDIR/stacks/incubator/java-microprofile
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stack-validate-java-microprofile.log
    [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-init-java-microprofile" {
    # init
    mkdir -p $TEMPDIR/java-microprofile
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY init -v dev.local/java-microprofile
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-java-microprofile.log
    [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-run-java-microprofile" {
    # run
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY run -v &
    echo "${output}" > $LOGDIR/integration-good-path-appsody-run-java-microprofile.log 
}
@test "integration-good-path-appsody-stop-java-microprofile" {
    # stop

    # sleep to let the container come up then capture the container id
    sleep 300
    CONTAINER=$($APPSODY ps | awk 'NR==2{print $2}')
    echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run-java-microprofile-ps-before-stop.log

    # stop the container
    run timeout 1m $APPSODY stop -v --name $CONTAINER
    echo "${output}"
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stop-java-microprofile.log
    [ "$status" -eq 0 ]

    # verify no running containers
    CONTAINER2=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run-java-microprofile-ps-after-kill.log
    run timeout 1m $APPSODY ps
    [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]

}
@test "integration-good-path-appsody-operator-install-java-microprofile" {
    # operator install
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator install --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-operator-install-java-microprofile.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-java-microprofile" {
    # deploy
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy --tag $TAG --pull-url $PULLURL --push-url $PUSHURL --push --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-java-microprofile.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-delete-java-microprofile" {
    # deploy delete
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy delete --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-delete-java-microprofile.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-operator-uninstall-java-microprofile" {
    # operator uninstall
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-operator-uninstall-java-microprofile.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-run2-java-microprofile" {
    skip
    # run
    # not able to log output from "appsody run &" due to the "&"
    cd $TEMPDIR/java-microprofile
    setsid $APPSODY run -v &> $LOGDIR/integration-good-path-appsody-run2-java-microprofile.log &

    # sleep to let the container come up then capture the container id
    sleep 300
    CONTAINER=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run2-java-microprofile-ps-before-kill.log
}
@test "integration-good-path-appsody-ctrl-c-java-microprofile" {
    skip
    # stop the running container
    # kill -2 to the groupid simulates a "CTRL-C"
    # need the [a]ppsody.* run to be sure we get the correct appsody binary
    PID=$(ps xao pgid,command | grep '[a]ppsody.* run' | awk '{print $1}')
    echo $PID > $LOGDIR/integration-good-path-appsody-run2-java-microprofile-PID.log
    kill -2 -$PID   

    # sleep to let the stop process complete
    sleep 11    

    # verify there are no running containers
    # nothing should be logged if there are no running containers
    CONTAINER2=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run2-java-microprofile-ps-after-kill.log
    run $APPSODY ps
    [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]
}
# java-spring-boot2
@test "integration-good-path-appsody-stack-validate-java-spring-boot2" {
    # validate
    cd $TEMPDIR/stacks/incubator/java-spring-boot2
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stack-validate-java-spring-boot2.log
    [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-init-java-spring-boot2" {
    # init
    mkdir -p $TEMPDIR/java-spring-boot2
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY init -v dev.local/java-spring-boot2
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-java-spring-boot2.log
    [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-run-java-spring-boot2" {
    # run
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY run -v &
    echo "${output}" > $LOGDIR/integration-good-path-appsody-run-java-spring-boot2.log 
}
@test "integration-good-path-appsody-stop-java-spring-boot2" {
    # stop

    # sleep to let the container come up then capture the container id
    sleep 300
    CONTAINER=$($APPSODY ps | awk 'NR==2{print $2}')
    echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run-java-spring-boot2-ps-before-stop.log

    # stop the container
    run timeout 1m $APPSODY stop -v --name $CONTAINER
    echo "${output}"
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stop-java-spring-boot2.log
    [ "$status" -eq 0 ]

    # verify no running containers
    CONTAINER2=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run-java-spring-boot2-ps-after-kill.log
    run timeout 1m $APPSODY ps
    [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]

}
@test "integration-good-path-appsody-operator-install-java-spring-boot2" {
    # operator install
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator install --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-operator-install-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-java-spring-boot2" {
    # deploy
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy --tag $TAG --pull-url $PULLURL --push-url $PUSHURL --push --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-delete-java-spring-boot2" {
    # deploy delete
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy delete --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-delete-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-operator-uninstall-java-spring-boot2" {
    # operator uninstall
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-operator-uninstall-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-run2-java-spring-boot2" {
    skip
    # run
    # not able to log output from "appsody run &" due to the "&"
    cd $TEMPDIR/java-spring-boot2
    setsid $APPSODY run -v &> $LOGDIR/integration-good-path-appsody-run2-java-spring-boot2.log &

    # sleep to let the container come up then capture the container id
    sleep 300
    CONTAINER=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run2-java-spring-boot2-ps-before-kill.log
}
@test "integration-good-path-appsody-ctrl-c-java-spring-boot2" {
    skip
    # stop the running container
    # kill -2 to the groupid simulates a "CTRL-C"
    # need the [a]ppsody.* run to be sure we get the correct appsody binary
    PID=$(ps xao pgid,command | grep '[a]ppsody.* run' | awk '{print $1}')
    echo $PID > $LOGDIR/integration-good-path-appsody-run2-java-spring-boot2-PID.log
    kill -2 -$PID   

    # sleep to let the stop process complete
    sleep 11    

    # verify there are no running containers
    # nothing should be logged if there are no running containers
    CONTAINER2=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run2-java-spring-boot2-ps-after-kill.log
    run $APPSODY ps
    [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]
}
# java-openliberty
@test "integration-good-path-appsody-stack-validate-java-openliberty" {
    # validate
    cd $TEMPDIR/stacks/incubator/java-openliberty
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stack-validate-java-openliberty.log
    [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-init-java-openliberty" {
    # init
    mkdir -p $TEMPDIR/java-openliberty
    cd $TEMPDIR/java-openliberty
    run timeout 1h $APPSODY init -v dev.local/java-openliberty
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-java-openliberty.log
    [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-run-java-openliberty" {
    # run
    cd $TEMPDIR/java-openliberty
    run timeout 1h $APPSODY run -v &
    echo "${output}" > $LOGDIR/integration-good-path-appsody-run-java-openliberty.log 
}
@test "integration-good-path-appsody-stop-java-openliberty" {
    # stop

    # sleep to let the container come up then capture the container id
    sleep 300
    CONTAINER=$($APPSODY ps | awk 'NR==2{print $2}')
    echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run-java-openliberty-ps-before-stop.log

    # stop the container
    run timeout 1m $APPSODY stop -v --name $CONTAINER
    echo "${output}"
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stop-java-openliberty.log
    [ "$status" -eq 0 ]

    # verify no running containers
    CONTAINER2=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run-java-openliberty-ps-after-kill.log
    run timeout 1m $APPSODY ps
    [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]

}
@test "integration-good-path-appsody-operator-install-java-openliberty" {
    # operator install
    cd $TEMPDIR/java-openliberty
    run timeout 1h $APPSODY operator install --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-operator-install-java-openliberty.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-java-openliberty" {
    # deploy
    cd $TEMPDIR/java-openliberty
    run timeout 1h $APPSODY deploy --tag $TAG --pull-url $PULLURL --push-url $PUSHURL --push --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-java-openliberty.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-delete-java-openliberty" {
    # deploy delete
    cd $TEMPDIR/java-openliberty
    run timeout 1h $APPSODY deploy delete --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-delete-java-openliberty.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-operator-uninstall-java-openliberty" {
    # operator uninstall
    cd $TEMPDIR/java-openliberty
    run timeout 1h $APPSODY operator uninstall --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-operator-uninstall-java-openliberty.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-run2-java-openliberty" {
    skip
    # run
    # not able to log output from "appsody run &" due to the "&"
    cd $TEMPDIR/java-openliberty
    setsid $APPSODY run -v &> $LOGDIR/integration-good-path-appsody-run2-java-openliberty.log &

    # sleep to let the container come up then capture the container id
    sleep 300
    CONTAINER=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run2-java-openliberty-ps-before-kill.log
}
@test "integration-good-path-appsody-ctrl-c-java-openliberty" {
    skip
    # stop the running container
    # kill -2 to the groupid simulates a "CTRL-C"
    # need the [a]ppsody.* run to be sure we get the correct appsody binary
    PID=$(ps xao pgid,command | grep '[a]ppsody.* run' | awk '{print $1}')
    echo $PID > $LOGDIR/integration-good-path-appsody-run2-java-openliberty-PID.log
    kill -2 -$PID   

    # sleep to let the stop process complete
    sleep 11    

    # verify there are no running containers
    # nothing should be logged if there are no running containers
    CONTAINER2=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run2-java-openliberty-ps-after-kill.log
    run $APPSODY ps
    [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]
}
# kitura
@test "integration-good-path-appsody-stack-validate-kitura" {
    # validate
    cd $TEMPDIR/stacks/incubator/kitura
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stack-validate-kitura.log
    [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-init-kitura" {
    # init
    mkdir -p $TEMPDIR/kitura
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY init -v dev.local/kitura
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-kitura.log
    [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-run-kitura" {
    # run
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY run -v &
    echo "${output}" > $LOGDIR/integration-good-path-appsody-run-kitura.log 
}
@test "integration-good-path-appsody-stop-kitura" {
    # stop

    # sleep to let the container come up then capture the container id
    sleep 300
    CONTAINER=$($APPSODY ps | awk 'NR==2{print $2}')
    echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run-kitura-ps-before-stop.log

    # stop the container
    run timeout 1m $APPSODY stop -v --name $CONTAINER
    echo "${output}"
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stop-kitura.log
    [ "$status" -eq 0 ]

    # verify no running containers
    CONTAINER2=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run-kitura-ps-after-kill.log
    run timeout 1m $APPSODY ps
    [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]

}
@test "integration-good-path-appsody-operator-install-kitura" {
    # operator install
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator install --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-operator-install-kitura.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-kitura" {
    # deploy
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy --tag $TAG --pull-url $PULLURL --push-url $PUSHURL --push --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-kitura.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-delete-kitura" {
    # deploy delete
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy delete --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-delete-kitura.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-operator-uninstall-kitura" {
    # operator uninstall
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-operator-uninstall-kitura.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-run2-kitura" {
    skip
    # run
    # not able to log output from "appsody run &" due to the "&"
    cd $TEMPDIR/kitura
    setsid $APPSODY run -v &> $LOGDIR/integration-good-path-appsody-run2-kitura.log &

    # sleep to let the container come up then capture the container id
    sleep 300
    CONTAINER=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run2-kitura-ps-before-kill.log
}
@test "integration-good-path-appsody-ctrl-c-kitura" {
    skip
    # stop the running container
    # kill -2 to the groupid simulates a "CTRL-C"
    # need the [a]ppsody.* run to be sure we get the correct appsody binary
    PID=$(ps xao pgid,command | grep '[a]ppsody.* run' | awk '{print $1}')
    echo $PID > $LOGDIR/integration-good-path-appsody-run2-kitura-PID.log
    kill -2 -$PID   

    # sleep to let the stop process complete
    sleep 11    

    # verify there are no running containers
    # nothing should be logged if there are no running containers
    CONTAINER2=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run2-kitura-ps-after-kill.log
    run $APPSODY ps
    [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]
}
# swift
@test "integration-good-path-appsody-stack-validate-swift" {
    # validate
    cd $TEMPDIR/stacks/incubator/swift
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stack-validate-swift.log
    [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-init-swift" {
    # init
    mkdir -p $TEMPDIR/swift
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY init -v dev.local/swift
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-swift.log
    [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-run-swift" {
    # run
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY run -v &
    echo "${output}" > $LOGDIR/integration-good-path-appsody-run-swift.log 
}
@test "integration-good-path-appsody-stop-swift" {
    # stop

    # sleep to let the container come up then capture the container id
    sleep 300
    CONTAINER=$($APPSODY ps | awk 'NR==2{print $2}')
    echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run-swift-ps-before-stop.log

    # stop the container
    run timeout 1m $APPSODY stop -v --name $CONTAINER
    echo "${output}"
    echo "${output}" > $LOGDIR/integration-good-path-appsody-stop-swift.log
    [ "$status" -eq 0 ]

    # verify no running containers
    CONTAINER2=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run-swift-ps-after-kill.log
    run timeout 1m $APPSODY ps
    [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]

}
@test "integration-good-path-appsody-operator-install-swift" {
    # operator install
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator install --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-operator-install-swift.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-swift" {
    # deploy
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy --tag $TAG --pull-url $PULLURL --push-url $PUSHURL --push --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-swift.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-delete-swift" {
    # deploy delete
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy delete --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-delete-swift.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-operator-uninstall-swift" {
    # operator uninstall
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-operator-uninstall-swift.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-run2-swift" {
    skip
    # run
    # not able to log output from "appsody run &" due to the "&"
    cd $TEMPDIR/swift
    setsid $APPSODY run -v &> $LOGDIR/integration-good-path-appsody-run2-swift.log &

    # sleep to let the container come up then capture the container id
    sleep 300
    CONTAINER=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER > $LOGDIR/integration-good-path-appsody-run2-swift-ps-before-kill.log
}
@test "integration-good-path-appsody-ctrl-c-swift" {
    skip
    # stop the running container
    # kill -2 to the groupid simulates a "CTRL-C"
    # need the [a]ppsody.* run to be sure we get the correct appsody binary
    PID=$(ps xao pgid,command | grep '[a]ppsody.* run' | awk '{print $1}')
    echo $PID > $LOGDIR/integration-good-path-appsody-run2-swift-PID.log
    kill -2 -$PID   

    # sleep to let the stop process complete
    sleep 11    

    # verify there are no running containers
    # nothing should be logged if there are no running containers
    CONTAINER2=$($APPSODY ps | awk 'NR==2{print $1}')
    echo $CONTAINER2 > $LOGDIR/integration-good-path-appsody-run2-swift-ps-after-kill.log
    run $APPSODY ps
    [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]
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
    echo "${output}" > $LOGDIR/integration-good-path-appsody-run-python-flask.log 
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
@test "integration-good-path-appsody-operator-install-python-flask" {
    # operator install
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator install --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-operator-install-python-flask.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-python-flask" {
    # deploy
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy --tag $TAG --pull-url $PULLURL --push-url $PUSHURL --push --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-python-flask.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-delete-python-flask" {
    # deploy delete
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy delete --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-delete-python-flask.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-operator-uninstall-python-flask" {
    # operator uninstall
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-operator-uninstall-python-flask.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-run2-python-flask" {
    skip
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
    skip
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
    echo "${output}" > $LOGDIR/integration-good-path-appsody-run-starter.log 
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
@test "integration-good-path-appsody-operator-install-starter" {
    # operator install
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator install --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-operator-install-starter.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-starter" {
    # deploy
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy --tag $TAG --pull-url $PULLURL --push-url $PUSHURL --push --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-starter.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-delete-starter" {
    # deploy delete
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy delete --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-delete-starter.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-operator-uninstall-starter" {
    # operator uninstall
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall --namespace $NAMESPACE -v
    echo "${output}" > $LOGDIR/integration-good-path-appsody-operator-uninstall-starter.log
    [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-run2-starter" {
    skip
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
    skip
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