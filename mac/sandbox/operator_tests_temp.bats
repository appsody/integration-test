load operator_helper
teardown() {
  if [[ "${#BATS_TEST_NAMES[@]}" -eq "$BATS_TEST_NUMBER" ]]; then
    rm -rf $GOPATH
  fi
}

# setup
@test "integration-operator_test1-good-path-appsody-init-nodejs" {
    # init
    mkdir -p $TEMPDIR/nodejs
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY init -v dev.local/nodejs
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-nodejs.log
    [ "$status" -eq 0 ]
}

# nodejs test 5
#0 appsody operator install --watchspace test
@test "integration-operator_test5-good-path-appsody-operator-install-watchspace-test-nodejs" {
    # operator install --watchspace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator install --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-install-watchspace-test-nodejs.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test5-bad-path-appsody-operator-install-namespace-test-nodejs" {
    # operator install --namespace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path-appsody-operator-install-namespace-test-nodejs.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test5-good-path-appsody-deploy-namespace-test-nodejs" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-namespace-test-nodejs.log
    [ "$status" -eq 0 ]  
}
#1 appsody deploy
@test "integration-operator_test5-bad-path-appsody-deploy-nodejs" {
    # deploy
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-nodejs.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test5-bad-path-appsody-operator-uninstall-nodejs" {
    # operator uninstall
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path-appsody-operator-uninstall-nodejs.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test5-good-path-appsody-deploy-delete-namespace-test-nodejs" {
    # deploy delete --namespace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-delete-namespace-test-nodejs.log
    [ "$status" -eq 0 ]  
    sleep 10
}
#0 appsody operator uninstall
@test "integration-operator_test5-good-path-appsody-operator-uninstall-nodejs" {
    # operator uninstall
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-uninstall-nodejs.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator install --watchspace test
@test "integration-operator_test5-good-path2-appsody-operator-install-watchspace-test-nodejs" {
    # operator install --watchspace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator install --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path2-appsody-operator-install-watchspace-test-nodejs.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test5-good-path2-appsody-deploy-namespace-test-nodejs" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path2-appsody-deploy-namespace-test-nodejs.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test5-bad-path2-appsody-operator-uninstall-nodejs" {
    # operator uninstall
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path2-appsody-operator-uninstall-nodejs.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test5-good-path-appsody-operator-uninstall-force-nodejs" {
    # operator uninstall --force
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-uninstall-force-nodejs.log
    [ "$status" -eq 0 ]  
    sleep 10
}


