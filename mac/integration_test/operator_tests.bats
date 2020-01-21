load integration_helper
teardown() {
  if [[ "${#BATS_TEST_NAMES[@]}" -eq "$BATS_TEST_NUMBER" ]]; then
    rm -rf $GOPATH
  fi
}


# setup
@test "integration-operator_setup-good-path-kubectl-create-ns-test" {
    # create ns test
    run timeout 1h kubectl create ns test
    echo "${output}" > $LOGDIR/integration-operator_setup-good-path-kubectl-create-ns-test.log
    [ "$status" -eq 0 ]
}
@test "integration-operator_setup-good-path-kubectl-create-ns-test2" {
    # create ns test2
    run timeout 1h kubectl create ns test2
    echo "${output}" > $LOGDIR/integration-operator_setup-good-path-kubectl-create-ns-test2.log
    [ "$status" -eq 0 ]
}

# nodejs test1
@test "integration-operator_test1-good-path-appsody-stack-validate-nodejs" {
    # validate
    cd $TEMPDIR/stacks/incubator/nodejs
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-stack-validate-nodejs.log
    [ "$status" -eq 0 ]
}
#0 appsody init
@test "integration-operator_test1-good-path-appsody-init-nodejs" {
    # init
    mkdir -p $TEMPDIR/nodejs
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY init -v dev.local/nodejs
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-nodejs.log
    [ "$status" -eq 0 ]
}
#0 appsody deploy
@test "integration-operator_test1-good-path-appsody-deploy-nodejs" {
    # deploy
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-deploy-nodejs.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install
@test "integration-operator_test1-bad-path-appsody-operator-install-nodejs" {
    # operator install
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test1-bad-path-appsody-operator-install-nodejs.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test1-bad-path-appsody-operator-uninstall-nodejs" {
    # operator uninstall
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test1-bad-path-appsody-operator-uninstall-nodejs.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test1-good-path-appsody-operator-uninstall-force-nodejs" {
    # operator uninstall --force
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-operator-uninstall-force-nodejs.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# nodejs test2
#0 appsody deploy --namespace test
@test "integration-operator_test2-good-path-appsody-deploy-namespace-test-nodejs" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-deploy-namespace-test-nodejs.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test2-bad-path-appsody-operator-install-namespace-test-nodejs" {
    # operator install --namespace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-install-namespace-test-nodejs.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test2-good-path-appsody-deploy-nodejs" {
    # deploy
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-deploy-nodejs.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test2-bad-path-appsody-operator-uninstall-namespace-test-nodejs" {
    # operator uninstall --namespace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-uninstall-namespace-test-nodejs.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test2-bad-path-appsody-operator-uninstall-nodejs" {
    # operator uninstall
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-uninstall-nodejs.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test2-good-path-appsody-operator-uninstall--namespace-test-force-nodejs" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-operator-uninstall-namespace-test-force-nodejs.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --force
@test "integration-operator_test2-good-path-appsody-operator-uninstall-force-nodejs" {
    # operator uninstall --force
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-operator-uninstall-force-nodejs.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# nodejs test 3
#0 appsody operator install
@test "integration-operator_test3-good-path-appsody-operator-install-nodejs" {
    # operator install
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-operator-install-nodejs.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy
@test "integration-operator_test3-good-path-appsody-deploy-nodejs" {
    # deploy
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-deploy-nodejs.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy delete
@test "integration-operator_test3-good-path-appsody-deploy-delete-nodejs" {
    # deploy delete
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy delete -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-deploy-delete-nodejs.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall
@test "integration-operator_test3-good-path-appsody-operator-uninstall-nodejs" {
    # operator uninstall
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-operator-uninstall-nodejs.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# nodejs test 4
#0 appsody operator install --namespace test
@test "integration-operator_test4-good-path-appsody-operator-install-namespace-test-nodejs" {
    # operator install --namespace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-operator-install-namespace-test-nodejs.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test4-bad-path-appsody-operator-uninstall-nodejs" {
    # operator uninstall
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test4-bad-path-appsody-operator-uninstall-nodejs.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test4-good-path-appsody-deploy-namespace-test-nodejs" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-deploy-namespace-test-nodejs.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#1 appsody deploy delete --namespace test2
@test "integration-operator_test4-bad-path-appsody-deploy-delete-namespace-test2-nodejs" {
    # deploy delete --namespace test2
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy delete --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test4-bad-path-appsody-deploy-delete-namespace-test2-nodejs.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test4-good-path-appsody-deploy-delete-namespace-test-nodejs" {
    # deploy delete --namespace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-deploy-delete-namespace-test-nodejs.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --namespace test
@test "integration-operator_test4-good-path-appsody-operator-uninstall-namespace-test-nodejs" {
    # operator uninstall --namespace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-operator-uninstall-namespace-test-nodejs.log
    [ "$status" -eq 0 ]  
    sleep 20
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
    sleep 20
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
    sleep 20
}

# nodejs test 6
#0 appsody operator install --namespace test --watchspace test2
@test "integration-operator_test6-good-path-appsody-operator-install-namespace-test-watchspace-test2-nodejs" {
    # operator install --namespace test --watchspace test2
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator install --namespace test --watchspace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-install-namespace-test-watchspace-test2-nodejs.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test2
@test "integration-operator_test6-bad-path-appsody-operator-install-namespace-test2-nodejs" {
    # operator install --namespace test2
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator install --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-install-namespace-test2-nodejs.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test6-good-path-appsody-deploy-namespace-test2-nodejs" {
    # deploy --namespace test2
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-deploy-namespace-test2-nodejs.log
    [ "$status" -eq 0 ]  
}
#1 appsody deploy --namespace test
@test "integration-operator_test6-bad-path-appsody-deploy-namespace-test-nodejs" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-deploy-namespace-test-nodejs.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator install --namespace test2 --watchspace test
@test "integration-operator_test6-good-path-appsody-operator-install-namespace-test2-watchspace-test-nodejs" {
    # operator install --namespace test2 --watchspace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator install --namespace test2 --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-install-namespace-test2-watchspace-test-nodejs.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test6-good-path-appsody-deploy-namespace-test-nodejs" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-deploy-namespace-test-nodejs.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test-nodejs" {
    # operator uninstall --namespace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test-nodejs.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test-force-nodejs" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test-force-nodejs.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#1 appsody operator uninstall
@test "integration-operator_test6-bad-path2-appsody-operator-uninstall-nodejs" {
    # operator uninstall
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path2-appsody-operator-uninstall-nodejs.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall --namespace test2
@test "integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test2-nodejs" {
    # operator uninstall --namespace test2
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test2-nodejs.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test6-good-path2-appsody-deploy-delete-namespace-test-nodejs" {
    # deploy delete --namespace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path2-appsody-deploy-delete-namespace-test-nodejs.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --namespace test2
@test "integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test2-nodejs" {
    # operator uninstall --namespace test2
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test2-nodejs.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# nodejs test 7
#0 appsody operator install --watch-all
@test "integration-operator_test7-good-path-appsody-operator-install-watch-all-nodejs" {
    # operator install --watch-all
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator install --watch-all -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-operator-install-watch-all-nodejs.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test7-bad-path-appsody-operator-install-namespace-test-nodejs" {
    # operator install --namespace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test7-bad-path-appsody-operator-install-namespace-test-nodejs.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test7-good-path-appsody-deploy-nodejs" {
    # deploy
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-nodejs.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody deploy --namespace test
@test "integration-operator_test7-good-path-appsody-deploy-namespace-test-nodejs" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-namespace-test-nodejs.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test7-good-path-appsody-deploy-namespace-test2-nodejs" {
    # deploy --namespace test2
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-namespace-test2-nodejs.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test7-bad-path-appsody-operator-uninstall-nodejs" {
    # operator uninstall
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test7-bad-path-appsody-operator-uninstall-nodejs.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test7-good-path-appsody-operator-uninstall-force-nodejs" {
    # operator uninstall --force
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-operator-uninstall-foce-nodejs.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# nodejs test 8
#0 appsody operator install --namespace test --watch-all
@test "integration-operator_test8-good-path-appsody-operator-install-namespace-test-watch-all-nodejs" {
    # operator install --namespace test --watch-all
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator install --namespace test --watch-all -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-operator-install-namespace-test-watch-all-nodejs.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install
@test "integration-operator_test8-bad-path-appsody-operator-install-nodejs" {
    # operator install
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-install-nodejs.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test8-good-path-appsody-deploy-nodejs" {
    # deploy
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-nodejs.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test8-good-path-appsody-deploy-namespace-test-nodejs" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-namespace-test-nodejs.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test8-good-path-appsody-deploy-namespace-test2-nodejs" {
    # deploy --namespace test2
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-namespace-test2-nodejs.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test8-bad-path-appsody-operator-uninstall-nodejs" {
    # operator uninstall
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-uninstall-nodejs.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test8-bad-path-appsody-operator-uninstall-namespace-test-nodejs" {
    # operator uninstall --namespace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-uninstall-namespace-test-nodejs.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test8-good-path-appsody-operator-uninstall--namespace-test-force-nodejs" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-operator-uninstall-namespace-test-foce-nodejs.log
    [ "$status" -eq 0 ]  
    sleep 20
}


# nodejs-express test1
@test "integration-operator_test1-good-path-appsody-stack-validate-nodejs-express" {
    # validate
    cd $TEMPDIR/stacks/incubator/nodejs-express
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-stack-validate-nodejs-express.log
    [ "$status" -eq 0 ]
}
#0 appsody init
@test "integration-operator_test1-good-path-appsody-init-nodejs-express" {
    # init
    mkdir -p $TEMPDIR/nodejs-express
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY init -v dev.local/nodejs-express
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-nodejs-express.log
    [ "$status" -eq 0 ]
}
#0 appsody deploy
@test "integration-operator_test1-good-path-appsody-deploy-nodejs-express" {
    # deploy
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-deploy-nodejs-express.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install
@test "integration-operator_test1-bad-path-appsody-operator-install-nodejs-express" {
    # operator install
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test1-bad-path-appsody-operator-install-nodejs-express.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test1-bad-path-appsody-operator-uninstall-nodejs-express" {
    # operator uninstall
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test1-bad-path-appsody-operator-uninstall-nodejs-express.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test1-good-path-appsody-operator-uninstall-force-nodejs-express" {
    # operator uninstall --force
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-operator-uninstall-force-nodejs-express.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# nodejs-express test2
#0 appsody deploy --namespace test
@test "integration-operator_test2-good-path-appsody-deploy-namespace-test-nodejs-express" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-deploy-namespace-test-nodejs-express.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test2-bad-path-appsody-operator-install-namespace-test-nodejs-express" {
    # operator install --namespace test
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-install-namespace-test-nodejs-express.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test2-good-path-appsody-deploy-nodejs-express" {
    # deploy
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-deploy-nodejs-express.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test2-bad-path-appsody-operator-uninstall-namespace-test-nodejs-express" {
    # operator uninstall --namespace test
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-uninstall-namespace-test-nodejs-express.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test2-bad-path-appsody-operator-uninstall-nodejs-express" {
    # operator uninstall
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-uninstall-nodejs-express.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test2-good-path-appsody-operator-uninstall--namespace-test-force-nodejs-express" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-operator-uninstall-namespace-test-force-nodejs-express.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --force
@test "integration-operator_test2-good-path-appsody-operator-uninstall-force-nodejs-express" {
    # operator uninstall --force
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-operator-uninstall-force-nodejs-express.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# nodejs-express test 3
#0 appsody operator install
@test "integration-operator_test3-good-path-appsody-operator-install-nodejs-express" {
    # operator install
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-operator-install-nodejs-express.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy
@test "integration-operator_test3-good-path-appsody-deploy-nodejs-express" {
    # deploy
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-deploy-nodejs-express.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy delete
@test "integration-operator_test3-good-path-appsody-deploy-delete-nodejs-express" {
    # deploy delete
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy delete -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-deploy-delete-nodejs-express.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall
@test "integration-operator_test3-good-path-appsody-operator-uninstall-nodejs-express" {
    # operator uninstall
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-operator-uninstall-nodejs-express.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# nodejs-express test 4
#0 appsody operator install --namespace test
@test "integration-operator_test4-good-path-appsody-operator-install-namespace-test-nodejs-express" {
    # operator install --namespace test
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-operator-install-namespace-test-nodejs-express.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test4-bad-path-appsody-operator-uninstall-nodejs-express" {
    # operator uninstall
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test4-bad-path-appsody-operator-uninstall-nodejs-express.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test4-good-path-appsody-deploy-namespace-test-nodejs-express" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-deploy-namespace-test-nodejs-express.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#1 appsody deploy delete --namespace test2
@test "integration-operator_test4-bad-path-appsody-deploy-delete-namespace-test2-nodejs-express" {
    # deploy delete --namespace test2
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy delete --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test4-bad-path-appsody-deploy-delete-namespace-test2-nodejs-express.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test4-good-path-appsody-deploy-delete-namespace-test-nodejs-express" {
    # deploy delete --namespace test
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-deploy-delete-namespace-test-nodejs-express.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --namespace test
@test "integration-operator_test4-good-path-appsody-operator-uninstall-namespace-test-nodejs-express" {
    # operator uninstall --namespace test
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-operator-uninstall-namespace-test-nodejs-express.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# nodejs-express test 5
#0 appsody operator install --watchspace test
@test "integration-operator_test5-good-path-appsody-operator-install-watchspace-test-nodejs-express" {
    # operator install --watchspace test
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator install --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-install-watchspace-test-nodejs-express.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test5-bad-path-appsody-operator-install-namespace-test-nodejs-express" {
    # operator install --namespace test
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path-appsody-operator-install-namespace-test-nodejs-express.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test5-good-path-appsody-deploy-namespace-test-nodejs-express" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-namespace-test-nodejs-express.log
    [ "$status" -eq 0 ]  
}
#1 appsody deploy
@test "integration-operator_test5-bad-path-appsody-deploy-nodejs-express" {
    # deploy
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-nodejs-express.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test5-bad-path-appsody-operator-uninstall-nodejs-express" {
    # operator uninstall
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path-appsody-operator-uninstall-nodejs-express.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test5-good-path-appsody-deploy-delete-namespace-test-nodejs-express" {
    # deploy delete --namespace test
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-delete-namespace-test-nodejs-express.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall
@test "integration-operator_test5-good-path-appsody-operator-uninstall-nodejs-express" {
    # operator uninstall
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-uninstall-nodejs-express.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator install --watchspace test
@test "integration-operator_test5-good-path2-appsody-operator-install-watchspace-test-nodejs-express" {
    # operator install --watchspace test
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator install --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path2-appsody-operator-install-watchspace-test-nodejs-express.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test5-good-path2-appsody-deploy-namespace-test-nodejs-express" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path2-appsody-deploy-namespace-test-nodejs-express.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test5-bad-path2-appsody-operator-uninstall-nodejs-express" {
    # operator uninstall
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path2-appsody-operator-uninstall-nodejs-express.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test5-good-path-appsody-operator-uninstall-force-nodejs-express" {
    # operator uninstall --force
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-uninstall-force-nodejs-express.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# nodejs-express test 6
#0 appsody operator install --namespace test --watchspace test2
@test "integration-operator_test6-good-path-appsody-operator-install-namespace-test-watchspace-test2-nodejs-express" {
    # operator install --namespace test --watchspace test2
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator install --namespace test --watchspace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-install-namespace-test-watchspace-test2-nodejs-express.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test2
@test "integration-operator_test6-bad-path-appsody-operator-install-namespace-test2-nodejs-express" {
    # operator install --namespace test2
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator install --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-install-namespace-test2-nodejs-express.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test6-good-path-appsody-deploy-namespace-test2-nodejs-express" {
    # deploy --namespace test2
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-deploy-namespace-test2-nodejs-express.log
    [ "$status" -eq 0 ]  
}
#1 appsody deploy --namespace test
@test "integration-operator_test6-bad-path-appsody-deploy-namespace-test-nodejs-express" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-deploy-namespace-test-nodejs-express.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator install --namespace test2 --watchspace test
@test "integration-operator_test6-good-path-appsody-operator-install-namespace-test2-watchspace-test-nodejs-express" {
    # operator install --namespace test2 --watchspace test
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator install --namespace test2 --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-install-namespace-test2-watchspace-test-nodejs-express.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test6-good-path-appsody-deploy-namespace-test-nodejs-express" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-deploy-namespace-test-nodejs-express.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test-nodejs-express" {
    # operator uninstall --namespace test
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test-nodejs-express.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test-force-nodejs-express" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test-force-nodejs-express.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#1 appsody operator uninstall
@test "integration-operator_test6-bad-path2-appsody-operator-uninstall-nodejs-express" {
    # operator uninstall
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path2-appsody-operator-uninstall-nodejs-express.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall --namespace test2
@test "integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test2-nodejs-express" {
    # operator uninstall --namespace test2
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test2-nodejs-express.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test6-good-path2-appsody-deploy-delete-namespace-test-nodejs-express" {
    # deploy delete --namespace test
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path2-appsody-deploy-delete-namespace-test-nodejs-express.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --namespace test2
@test "integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test2-nodejs-express" {
    # operator uninstall --namespace test2
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test2-nodejs-express.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# nodejs-express test 7
#0 appsody operator install --watch-all
@test "integration-operator_test7-good-path-appsody-operator-install-watch-all-nodejs-express" {
    # operator install --watch-all
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator install --watch-all -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-operator-install-watch-all-nodejs-express.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test7-bad-path-appsody-operator-install-namespace-test-nodejs-express" {
    # operator install --namespace test
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test7-bad-path-appsody-operator-install-namespace-test-nodejs-express.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test7-good-path-appsody-deploy-nodejs-express" {
    # deploy
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-nodejs-express.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody deploy --namespace test
@test "integration-operator_test7-good-path-appsody-deploy-namespace-test-nodejs-express" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-namespace-test-nodejs-express.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test7-good-path-appsody-deploy-namespace-test2-nodejs-express" {
    # deploy --namespace test2
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-namespace-test2-nodejs-express.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test7-bad-path-appsody-operator-uninstall-nodejs-express" {
    # operator uninstall
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test7-bad-path-appsody-operator-uninstall-nodejs-express.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test7-good-path-appsody-operator-uninstall-force-nodejs-express" {
    # operator uninstall --force
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-operator-uninstall-foce-nodejs-express.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# nodejs-express test 8
#0 appsody operator install --namespace test --watch-all
@test "integration-operator_test8-good-path-appsody-operator-install-namespace-test-watch-all-nodejs-express" {
    # operator install --namespace test --watch-all
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator install --namespace test --watch-all -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-operator-install-namespace-test-watch-all-nodejs-express.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install
@test "integration-operator_test8-bad-path-appsody-operator-install-nodejs-express" {
    # operator install
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-install-nodejs-express.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test8-good-path-appsody-deploy-nodejs-express" {
    # deploy
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-nodejs-express.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test8-good-path-appsody-deploy-namespace-test-nodejs-express" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-namespace-test-nodejs-express.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test8-good-path-appsody-deploy-namespace-test2-nodejs-express" {
    # deploy --namespace test2
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-namespace-test2-nodejs-express.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test8-bad-path-appsody-operator-uninstall-nodejs-express" {
    # operator uninstall
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-uninstall-nodejs-express.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test8-bad-path-appsody-operator-uninstall-namespace-test-nodejs-express" {
    # operator uninstall --namespace test
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-uninstall-namespace-test-nodejs-express.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test8-good-path-appsody-operator-uninstall--namespace-test-force-nodejs-express" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-operator-uninstall-namespace-test-foce-nodejs-express.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# nodejs-loopback test1
@test "integration-operator_test1-good-path-appsody-stack-validate-nodejs-loopback" {
    # validate
    cd $TEMPDIR/stacks/incubator/nodejs-loopback
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-stack-validate-nodejs-loopback.log
    [ "$status" -eq 0 ]
}
#0 appsody init
@test "integration-operator_test1-good-path-appsody-init-nodejs-loopback" {
    # init
    mkdir -p $TEMPDIR/nodejs-loopback
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY init -v dev.local/nodejs-loopback
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-nodejs-loopback.log
    [ "$status" -eq 0 ]
}
#0 appsody deploy
@test "integration-operator_test1-good-path-appsody-deploy-nodejs-loopback" {
    # deploy
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-deploy-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install
@test "integration-operator_test1-bad-path-appsody-operator-install-nodejs-loopback" {
    # operator install
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test1-bad-path-appsody-operator-install-nodejs-loopback.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test1-bad-path-appsody-operator-uninstall-nodejs-loopback" {
    # operator uninstall
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test1-bad-path-appsody-operator-uninstall-nodejs-loopback.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test1-good-path-appsody-operator-uninstall-force-nodejs-loopback" {
    # operator uninstall --force
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-operator-uninstall-force-nodejs-loopback.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# nodejs-loopback test2
#0 appsody deploy --namespace test
@test "integration-operator_test2-good-path-appsody-deploy-namespace-test-nodejs-loopback" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-deploy-namespace-test-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test2-bad-path-appsody-operator-install-namespace-test-nodejs-loopback" {
    # operator install --namespace test
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-install-namespace-test-nodejs-loopback.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test2-good-path-appsody-deploy-nodejs-loopback" {
    # deploy
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-deploy-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test2-bad-path-appsody-operator-uninstall-namespace-test-nodejs-loopback" {
    # operator uninstall --namespace test
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-uninstall-namespace-test-nodejs-loopback.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test2-bad-path-appsody-operator-uninstall-nodejs-loopback" {
    # operator uninstall
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-uninstall-nodejs-loopback.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test2-good-path-appsody-operator-uninstall--namespace-test-force-nodejs-loopback" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-operator-uninstall-namespace-test-force-nodejs-loopback.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --force
@test "integration-operator_test2-good-path-appsody-operator-uninstall-force-nodejs-loopback" {
    # operator uninstall --force
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-operator-uninstall-force-nodejs-loopback.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# nodejs-loopback test 3
#0 appsody operator install
@test "integration-operator_test3-good-path-appsody-operator-install-nodejs-loopback" {
    # operator install
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-operator-install-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy
@test "integration-operator_test3-good-path-appsody-deploy-nodejs-loopback" {
    # deploy
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-deploy-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy delete
@test "integration-operator_test3-good-path-appsody-deploy-delete-nodejs-loopback" {
    # deploy delete
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy delete -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-deploy-delete-nodejs-loopback.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall
@test "integration-operator_test3-good-path-appsody-operator-uninstall-nodejs-loopback" {
    # operator uninstall
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-operator-uninstall-nodejs-loopback.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# nodejs-loopback test 4
#0 appsody operator install --namespace test
@test "integration-operator_test4-good-path-appsody-operator-install-namespace-test-nodejs-loopback" {
    # operator install --namespace test
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-operator-install-namespace-test-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test4-bad-path-appsody-operator-uninstall-nodejs-loopback" {
    # operator uninstall
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test4-bad-path-appsody-operator-uninstall-nodejs-loopback.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test4-good-path-appsody-deploy-namespace-test-nodejs-loopback" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-deploy-namespace-test-nodejs-loopback.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#1 appsody deploy delete --namespace test2
@test "integration-operator_test4-bad-path-appsody-deploy-delete-namespace-test2-nodejs-loopback" {
    # deploy delete --namespace test2
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy delete --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test4-bad-path-appsody-deploy-delete-namespace-test2-nodejs-loopback.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test4-good-path-appsody-deploy-delete-namespace-test-nodejs-loopback" {
    # deploy delete --namespace test
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-deploy-delete-namespace-test-nodejs-loopback.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --namespace test
@test "integration-operator_test4-good-path-appsody-operator-uninstall-namespace-test-nodejs-loopback" {
    # operator uninstall --namespace test
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-operator-uninstall-namespace-test-nodejs-loopback.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# nodejs-loopback test 5
#0 appsody operator install --watchspace test
@test "integration-operator_test5-good-path-appsody-operator-install-watchspace-test-nodejs-loopback" {
    # operator install --watchspace test
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator install --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-install-watchspace-test-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test5-bad-path-appsody-operator-install-namespace-test-nodejs-loopback" {
    # operator install --namespace test
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path-appsody-operator-install-namespace-test-nodejs-loopback.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test5-good-path-appsody-deploy-namespace-test-nodejs-loopback" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-namespace-test-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
#1 appsody deploy
@test "integration-operator_test5-bad-path-appsody-deploy-nodejs-loopback" {
    # deploy
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-nodejs-loopback.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test5-bad-path-appsody-operator-uninstall-nodejs-loopback" {
    # operator uninstall
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path-appsody-operator-uninstall-nodejs-loopback.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test5-good-path-appsody-deploy-delete-namespace-test-nodejs-loopback" {
    # deploy delete --namespace test
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-delete-namespace-test-nodejs-loopback.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall
@test "integration-operator_test5-good-path-appsody-operator-uninstall-nodejs-loopback" {
    # operator uninstall
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-uninstall-nodejs-loopback.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator install --watchspace test
@test "integration-operator_test5-good-path2-appsody-operator-install-watchspace-test-nodejs-loopback" {
    # operator install --watchspace test
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator install --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path2-appsody-operator-install-watchspace-test-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test5-good-path2-appsody-deploy-namespace-test-nodejs-loopback" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path2-appsody-deploy-namespace-test-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test5-bad-path2-appsody-operator-uninstall-nodejs-loopback" {
    # operator uninstall
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path2-appsody-operator-uninstall-nodejs-loopback.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test5-good-path-appsody-operator-uninstall-force-nodejs-loopback" {
    # operator uninstall --force
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-uninstall-force-nodejs-loopback.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# nodejs-loopback test 6
#0 appsody operator install --namespace test --watchspace test2
@test "integration-operator_test6-good-path-appsody-operator-install-namespace-test-watchspace-test2-nodejs-loopback" {
    # operator install --namespace test --watchspace test2
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator install --namespace test --watchspace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-install-namespace-test-watchspace-test2-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test2
@test "integration-operator_test6-bad-path-appsody-operator-install-namespace-test2-nodejs-loopback" {
    # operator install --namespace test2
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator install --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-install-namespace-test2-nodejs-loopback.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test6-good-path-appsody-deploy-namespace-test2-nodejs-loopback" {
    # deploy --namespace test2
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-deploy-namespace-test2-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
#1 appsody deploy --namespace test
@test "integration-operator_test6-bad-path-appsody-deploy-namespace-test-nodejs-loopback" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-deploy-namespace-test-nodejs-loopback.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator install --namespace test2 --watchspace test
@test "integration-operator_test6-good-path-appsody-operator-install-namespace-test2-watchspace-test-nodejs-loopback" {
    # operator install --namespace test2 --watchspace test
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator install --namespace test2 --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-install-namespace-test2-watchspace-test-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test6-good-path-appsody-deploy-namespace-test-nodejs-loopback" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-deploy-namespace-test-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test-nodejs-loopback" {
    # operator uninstall --namespace test
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test-nodejs-loopback.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test-force-nodejs-loopback" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test-force-nodejs-loopback.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#1 appsody operator uninstall
@test "integration-operator_test6-bad-path2-appsody-operator-uninstall-nodejs-loopback" {
    # operator uninstall
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path2-appsody-operator-uninstall-nodejs-loopback.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall --namespace test2
@test "integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test2-nodejs-loopback" {
    # operator uninstall --namespace test2
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test2-nodejs-loopback.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test6-good-path2-appsody-deploy-delete-namespace-test-nodejs-loopback" {
    # deploy delete --namespace test
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path2-appsody-deploy-delete-namespace-test-nodejs-loopback.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --namespace test2
@test "integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test2-nodejs-loopback" {
    # operator uninstall --namespace test2
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test2-nodejs-loopback.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# nodejs-loopback test 7
#0 appsody operator install --watch-all
@test "integration-operator_test7-good-path-appsody-operator-install-watch-all-nodejs-loopback" {
    # operator install --watch-all
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator install --watch-all -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-operator-install-watch-all-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test7-bad-path-appsody-operator-install-namespace-test-nodejs-loopback" {
    # operator install --namespace test
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test7-bad-path-appsody-operator-install-namespace-test-nodejs-loopback.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test7-good-path-appsody-deploy-nodejs-loopback" {
    # deploy
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-nodejs-loopback.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody deploy --namespace test
@test "integration-operator_test7-good-path-appsody-deploy-namespace-test-nodejs-loopback" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-namespace-test-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test7-good-path-appsody-deploy-namespace-test2-nodejs-loopback" {
    # deploy --namespace test2
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-namespace-test2-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test7-bad-path-appsody-operator-uninstall-nodejs-loopback" {
    # operator uninstall
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test7-bad-path-appsody-operator-uninstall-nodejs-loopback.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test7-good-path-appsody-operator-uninstall-force-nodejs-loopback" {
    # operator uninstall --force
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-operator-uninstall-foce-nodejs-loopback.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# nodejs-loopback test 8
#0 appsody operator install --namespace test --watch-all
@test "integration-operator_test8-good-path-appsody-operator-install-namespace-test-watch-all-nodejs-loopback" {
    # operator install --namespace test --watch-all
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator install --namespace test --watch-all -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-operator-install-namespace-test-watch-all-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install
@test "integration-operator_test8-bad-path-appsody-operator-install-nodejs-loopback" {
    # operator install
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-install-nodejs-loopback.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test8-good-path-appsody-deploy-nodejs-loopback" {
    # deploy
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test8-good-path-appsody-deploy-namespace-test-nodejs-loopback" {
    # deploy --namespace test
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-namespace-test-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test8-good-path-appsody-deploy-namespace-test2-nodejs-loopback" {
    # deploy --namespace test2
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-namespace-test2-nodejs-loopback.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test8-bad-path-appsody-operator-uninstall-nodejs-loopback" {
    # operator uninstall
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-uninstall-nodejs-loopback.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test8-bad-path-appsody-operator-uninstall-namespace-test-nodejs-loopback" {
    # operator uninstall --namespace test
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-uninstall-namespace-test-nodejs-loopback.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test8-good-path-appsody-operator-uninstall--namespace-test-force-nodejs-loopback" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/nodejs-loopback
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-operator-uninstall-namespace-test-foce-nodejs-loopback.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# node-red test1
@test "integration-operator_test1-good-path-appsody-stack-validate-node-red" {
    # validate
    cd $TEMPDIR/stacks/incubator/node-red
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-stack-validate-node-red.log
    [ "$status" -eq 0 ]
}
#0 appsody init
@test "integration-operator_test1-good-path-appsody-init-node-red" {
    # init
    mkdir -p $TEMPDIR/node-red
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY init -v dev.local/node-red
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-node-red.log
    [ "$status" -eq 0 ]
}
#0 appsody deploy
@test "integration-operator_test1-good-path-appsody-deploy-node-red" {
    # deploy
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-deploy-node-red.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install
@test "integration-operator_test1-bad-path-appsody-operator-install-node-red" {
    # operator install
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test1-bad-path-appsody-operator-install-node-red.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test1-bad-path-appsody-operator-uninstall-node-red" {
    # operator uninstall
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test1-bad-path-appsody-operator-uninstall-node-red.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test1-good-path-appsody-operator-uninstall-force-node-red" {
    # operator uninstall --force
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-operator-uninstall-force-node-red.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# node-red test2
#0 appsody deploy --namespace test
@test "integration-operator_test2-good-path-appsody-deploy-namespace-test-node-red" {
    # deploy --namespace test
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-deploy-namespace-test-node-red.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test2-bad-path-appsody-operator-install-namespace-test-node-red" {
    # operator install --namespace test
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-install-namespace-test-node-red.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test2-good-path-appsody-deploy-node-red" {
    # deploy
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-deploy-node-red.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test2-bad-path-appsody-operator-uninstall-namespace-test-node-red" {
    # operator uninstall --namespace test
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-uninstall-namespace-test-node-red.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test2-bad-path-appsody-operator-uninstall-node-red" {
    # operator uninstall
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-uninstall-node-red.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test2-good-path-appsody-operator-uninstall--namespace-test-force-node-red" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-operator-uninstall-namespace-test-force-node-red.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --force
@test "integration-operator_test2-good-path-appsody-operator-uninstall-force-node-red" {
    # operator uninstall --force
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-operator-uninstall-force-node-red.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# node-red test 3
#0 appsody operator install
@test "integration-operator_test3-good-path-appsody-operator-install-node-red" {
    # operator install
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-operator-install-node-red.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy
@test "integration-operator_test3-good-path-appsody-deploy-node-red" {
    # deploy
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-deploy-node-red.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy delete
@test "integration-operator_test3-good-path-appsody-deploy-delete-node-red" {
    # deploy delete
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy delete -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-deploy-delete-node-red.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall
@test "integration-operator_test3-good-path-appsody-operator-uninstall-node-red" {
    # operator uninstall
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-operator-uninstall-node-red.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# node-red test 4
#0 appsody operator install --namespace test
@test "integration-operator_test4-good-path-appsody-operator-install-namespace-test-node-red" {
    # operator install --namespace test
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-operator-install-namespace-test-node-red.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test4-bad-path-appsody-operator-uninstall-node-red" {
    # operator uninstall
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test4-bad-path-appsody-operator-uninstall-node-red.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test4-good-path-appsody-deploy-namespace-test-node-red" {
    # deploy --namespace test
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-deploy-namespace-test-node-red.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#1 appsody deploy delete --namespace test2
@test "integration-operator_test4-bad-path-appsody-deploy-delete-namespace-test2-node-red" {
    # deploy delete --namespace test2
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy delete --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test4-bad-path-appsody-deploy-delete-namespace-test2-node-red.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test4-good-path-appsody-deploy-delete-namespace-test-node-red" {
    # deploy delete --namespace test
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-deploy-delete-namespace-test-node-red.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --namespace test
@test "integration-operator_test4-good-path-appsody-operator-uninstall-namespace-test-node-red" {
    # operator uninstall --namespace test
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-operator-uninstall-namespace-test-node-red.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# node-red test 5
#0 appsody operator install --watchspace test
@test "integration-operator_test5-good-path-appsody-operator-install-watchspace-test-node-red" {
    # operator install --watchspace test
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator install --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-install-watchspace-test-node-red.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test5-bad-path-appsody-operator-install-namespace-test-node-red" {
    # operator install --namespace test
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path-appsody-operator-install-namespace-test-node-red.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test5-good-path-appsody-deploy-namespace-test-node-red" {
    # deploy --namespace test
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-namespace-test-node-red.log
    [ "$status" -eq 0 ]  
}
#1 appsody deploy
@test "integration-operator_test5-bad-path-appsody-deploy-node-red" {
    # deploy
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-node-red.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test5-bad-path-appsody-operator-uninstall-node-red" {
    # operator uninstall
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path-appsody-operator-uninstall-node-red.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test5-good-path-appsody-deploy-delete-namespace-test-node-red" {
    # deploy delete --namespace test
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-delete-namespace-test-node-red.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall
@test "integration-operator_test5-good-path-appsody-operator-uninstall-node-red" {
    # operator uninstall
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-uninstall-node-red.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator install --watchspace test
@test "integration-operator_test5-good-path2-appsody-operator-install-watchspace-test-node-red" {
    # operator install --watchspace test
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator install --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path2-appsody-operator-install-watchspace-test-node-red.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test5-good-path2-appsody-deploy-namespace-test-node-red" {
    # deploy --namespace test
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path2-appsody-deploy-namespace-test-node-red.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test5-bad-path2-appsody-operator-uninstall-node-red" {
    # operator uninstall
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path2-appsody-operator-uninstall-node-red.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test5-good-path-appsody-operator-uninstall-force-node-red" {
    # operator uninstall --force
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-uninstall-force-node-red.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# node-red test 6
#0 appsody operator install --namespace test --watchspace test2
@test "integration-operator_test6-good-path-appsody-operator-install-namespace-test-watchspace-test2-node-red" {
    # operator install --namespace test --watchspace test2
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator install --namespace test --watchspace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-install-namespace-test-watchspace-test2-node-red.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test2
@test "integration-operator_test6-bad-path-appsody-operator-install-namespace-test2-node-red" {
    # operator install --namespace test2
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator install --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-install-namespace-test2-node-red.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test6-good-path-appsody-deploy-namespace-test2-node-red" {
    # deploy --namespace test2
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-deploy-namespace-test2-node-red.log
    [ "$status" -eq 0 ]  
}
#1 appsody deploy --namespace test
@test "integration-operator_test6-bad-path-appsody-deploy-namespace-test-node-red" {
    # deploy --namespace test
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-deploy-namespace-test-node-red.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator install --namespace test2 --watchspace test
@test "integration-operator_test6-good-path-appsody-operator-install-namespace-test2-watchspace-test-node-red" {
    # operator install --namespace test2 --watchspace test
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator install --namespace test2 --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-install-namespace-test2-watchspace-test-node-red.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test6-good-path-appsody-deploy-namespace-test-node-red" {
    # deploy --namespace test
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-deploy-namespace-test-node-red.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test-node-red" {
    # operator uninstall --namespace test
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test-node-red.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test-force-node-red" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test-force-node-red.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#1 appsody operator uninstall
@test "integration-operator_test6-bad-path2-appsody-operator-uninstall-node-red" {
    # operator uninstall
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path2-appsody-operator-uninstall-node-red.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall --namespace test2
@test "integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test2-node-red" {
    # operator uninstall --namespace test2
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test2-node-red.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test6-good-path2-appsody-deploy-delete-namespace-test-node-red" {
    # deploy delete --namespace test
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path2-appsody-deploy-delete-namespace-test-node-red.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --namespace test2
@test "integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test2-node-red" {
    # operator uninstall --namespace test2
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test2-node-red.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# node-red test 7
#0 appsody operator install --watch-all
@test "integration-operator_test7-good-path-appsody-operator-install-watch-all-node-red" {
    # operator install --watch-all
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator install --watch-all -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-operator-install-watch-all-node-red.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test7-bad-path-appsody-operator-install-namespace-test-node-red" {
    # operator install --namespace test
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test7-bad-path-appsody-operator-install-namespace-test-node-red.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test7-good-path-appsody-deploy-node-red" {
    # deploy
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-node-red.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody deploy --namespace test
@test "integration-operator_test7-good-path-appsody-deploy-namespace-test-node-red" {
    # deploy --namespace test
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-namespace-test-node-red.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test7-good-path-appsody-deploy-namespace-test2-node-red" {
    # deploy --namespace test2
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-namespace-test2-node-red.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test7-bad-path-appsody-operator-uninstall-node-red" {
    # operator uninstall
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test7-bad-path-appsody-operator-uninstall-node-red.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test7-good-path-appsody-operator-uninstall-force-node-red" {
    # operator uninstall --force
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-operator-uninstall-foce-node-red.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# node-red test 8
#0 appsody operator install --namespace test --watch-all
@test "integration-operator_test8-good-path-appsody-operator-install-namespace-test-watch-all-node-red" {
    # operator install --namespace test --watch-all
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator install --namespace test --watch-all -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-operator-install-namespace-test-watch-all-node-red.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install
@test "integration-operator_test8-bad-path-appsody-operator-install-node-red" {
    # operator install
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-install-node-red.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test8-good-path-appsody-deploy-node-red" {
    # deploy
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-node-red.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test8-good-path-appsody-deploy-namespace-test-node-red" {
    # deploy --namespace test
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-namespace-test-node-red.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test8-good-path-appsody-deploy-namespace-test2-node-red" {
    # deploy --namespace test2
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-namespace-test2-node-red.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test8-bad-path-appsody-operator-uninstall-node-red" {
    # operator uninstall
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-uninstall-node-red.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test8-bad-path-appsody-operator-uninstall-namespace-test-node-red" {
    # operator uninstall --namespace test
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-uninstall-namespace-test-node-red.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test8-good-path-appsody-operator-uninstall--namespace-test-force-node-red" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/node-red
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-operator-uninstall-namespace-test-foce-node-red.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# java-microprofile test1
@test "integration-operator_test1-good-path-appsody-stack-validate-java-microprofile" {
    # validate
    cd $TEMPDIR/stacks/incubator/java-microprofile
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-stack-validate-java-microprofile.log
    [ "$status" -eq 0 ]
}
#0 appsody init
@test "integration-operator_test1-good-path-appsody-init-java-microprofile" {
    # init
    mkdir -p $TEMPDIR/java-microprofile
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY init -v dev.local/java-microprofile
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-java-microprofile.log
    [ "$status" -eq 0 ]
}
#0 appsody deploy
@test "integration-operator_test1-good-path-appsody-deploy-java-microprofile" {
    # deploy
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-deploy-java-microprofile.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install
@test "integration-operator_test1-bad-path-appsody-operator-install-java-microprofile" {
    # operator install
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test1-bad-path-appsody-operator-install-java-microprofile.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test1-bad-path-appsody-operator-uninstall-java-microprofile" {
    # operator uninstall
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test1-bad-path-appsody-operator-uninstall-java-microprofile.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test1-good-path-appsody-operator-uninstall-force-java-microprofile" {
    # operator uninstall --force
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-operator-uninstall-force-java-microprofile.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# java-microprofile test2
#0 appsody deploy --namespace test
@test "integration-operator_test2-good-path-appsody-deploy-namespace-test-java-microprofile" {
    # deploy --namespace test
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-deploy-namespace-test-java-microprofile.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test2-bad-path-appsody-operator-install-namespace-test-java-microprofile" {
    # operator install --namespace test
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-install-namespace-test-java-microprofile.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test2-good-path-appsody-deploy-java-microprofile" {
    # deploy
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-deploy-java-microprofile.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test2-bad-path-appsody-operator-uninstall-namespace-test-java-microprofile" {
    # operator uninstall --namespace test
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-uninstall-namespace-test-java-microprofile.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test2-bad-path-appsody-operator-uninstall-java-microprofile" {
    # operator uninstall
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-uninstall-java-microprofile.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test2-good-path-appsody-operator-uninstall--namespace-test-force-java-microprofile" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-operator-uninstall-namespace-test-force-java-microprofile.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --force
@test "integration-operator_test2-good-path-appsody-operator-uninstall-force-java-microprofile" {
    # operator uninstall --force
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-operator-uninstall-force-java-microprofile.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# java-microprofile test 3
#0 appsody operator install
@test "integration-operator_test3-good-path-appsody-operator-install-java-microprofile" {
    # operator install
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-operator-install-java-microprofile.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy
@test "integration-operator_test3-good-path-appsody-deploy-java-microprofile" {
    # deploy
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-deploy-java-microprofile.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy delete
@test "integration-operator_test3-good-path-appsody-deploy-delete-java-microprofile" {
    # deploy delete
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy delete -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-deploy-delete-java-microprofile.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall
@test "integration-operator_test3-good-path-appsody-operator-uninstall-java-microprofile" {
    # operator uninstall
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-operator-uninstall-java-microprofile.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# java-microprofile test 4
#0 appsody operator install --namespace test
@test "integration-operator_test4-good-path-appsody-operator-install-namespace-test-java-microprofile" {
    # operator install --namespace test
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-operator-install-namespace-test-java-microprofile.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test4-bad-path-appsody-operator-uninstall-java-microprofile" {
    # operator uninstall
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test4-bad-path-appsody-operator-uninstall-java-microprofile.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test4-good-path-appsody-deploy-namespace-test-java-microprofile" {
    # deploy --namespace test
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-deploy-namespace-test-java-microprofile.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#1 appsody deploy delete --namespace test2
@test "integration-operator_test4-bad-path-appsody-deploy-delete-namespace-test2-java-microprofile" {
    # deploy delete --namespace test2
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy delete --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test4-bad-path-appsody-deploy-delete-namespace-test2-java-microprofile.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test4-good-path-appsody-deploy-delete-namespace-test-java-microprofile" {
    # deploy delete --namespace test
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-deploy-delete-namespace-test-java-microprofile.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --namespace test
@test "integration-operator_test4-good-path-appsody-operator-uninstall-namespace-test-java-microprofile" {
    # operator uninstall --namespace test
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-operator-uninstall-namespace-test-java-microprofile.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# java-microprofile test 5
#0 appsody operator install --watchspace test
@test "integration-operator_test5-good-path-appsody-operator-install-watchspace-test-java-microprofile" {
    # operator install --watchspace test
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator install --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-install-watchspace-test-java-microprofile.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test5-bad-path-appsody-operator-install-namespace-test-java-microprofile" {
    # operator install --namespace test
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path-appsody-operator-install-namespace-test-java-microprofile.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test5-good-path-appsody-deploy-namespace-test-java-microprofile" {
    # deploy --namespace test
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-namespace-test-java-microprofile.log
    [ "$status" -eq 0 ]  
}
#1 appsody deploy
@test "integration-operator_test5-bad-path-appsody-deploy-java-microprofile" {
    # deploy
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-java-microprofile.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test5-bad-path-appsody-operator-uninstall-java-microprofile" {
    # operator uninstall
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path-appsody-operator-uninstall-java-microprofile.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test5-good-path-appsody-deploy-delete-namespace-test-java-microprofile" {
    # deploy delete --namespace test
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-delete-namespace-test-java-microprofile.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall
@test "integration-operator_test5-good-path-appsody-operator-uninstall-java-microprofile" {
    # operator uninstall
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-uninstall-java-microprofile.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator install --watchspace test
@test "integration-operator_test5-good-path2-appsody-operator-install-watchspace-test-java-microprofile" {
    # operator install --watchspace test
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator install --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path2-appsody-operator-install-watchspace-test-java-microprofile.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test5-good-path2-appsody-deploy-namespace-test-java-microprofile" {
    # deploy --namespace test
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path2-appsody-deploy-namespace-test-java-microprofile.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test5-bad-path2-appsody-operator-uninstall-java-microprofile" {
    # operator uninstall
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path2-appsody-operator-uninstall-java-microprofile.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test5-good-path-appsody-operator-uninstall-force-java-microprofile" {
    # operator uninstall --force
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-uninstall-force-java-microprofile.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# java-microprofile test 6
#0 appsody operator install --namespace test --watchspace test2
@test "integration-operator_test6-good-path-appsody-operator-install-namespace-test-watchspace-test2-java-microprofile" {
    # operator install --namespace test --watchspace test2
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator install --namespace test --watchspace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-install-namespace-test-watchspace-test2-java-microprofile.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test2
@test "integration-operator_test6-bad-path-appsody-operator-install-namespace-test2-java-microprofile" {
    # operator install --namespace test2
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator install --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-install-namespace-test2-java-microprofile.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test6-good-path-appsody-deploy-namespace-test2-java-microprofile" {
    # deploy --namespace test2
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-deploy-namespace-test2-java-microprofile.log
    [ "$status" -eq 0 ]  
}
#1 appsody deploy --namespace test
@test "integration-operator_test6-bad-path-appsody-deploy-namespace-test-java-microprofile" {
    # deploy --namespace test
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-deploy-namespace-test-java-microprofile.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator install --namespace test2 --watchspace test
@test "integration-operator_test6-good-path-appsody-operator-install-namespace-test2-watchspace-test-java-microprofile" {
    # operator install --namespace test2 --watchspace test
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator install --namespace test2 --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-install-namespace-test2-watchspace-test-java-microprofile.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test6-good-path-appsody-deploy-namespace-test-java-microprofile" {
    # deploy --namespace test
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-deploy-namespace-test-java-microprofile.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test-java-microprofile" {
    # operator uninstall --namespace test
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test-java-microprofile.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test-force-java-microprofile" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test-force-java-microprofile.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#1 appsody operator uninstall
@test "integration-operator_test6-bad-path2-appsody-operator-uninstall-java-microprofile" {
    # operator uninstall
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path2-appsody-operator-uninstall-java-microprofile.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall --namespace test2
@test "integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test2-java-microprofile" {
    # operator uninstall --namespace test2
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test2-java-microprofile.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test6-good-path2-appsody-deploy-delete-namespace-test-java-microprofile" {
    # deploy delete --namespace test
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path2-appsody-deploy-delete-namespace-test-java-microprofile.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --namespace test2
@test "integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test2-java-microprofile" {
    # operator uninstall --namespace test2
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test2-java-microprofile.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# java-microprofile test 7
#0 appsody operator install --watch-all
@test "integration-operator_test7-good-path-appsody-operator-install-watch-all-java-microprofile" {
    # operator install --watch-all
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator install --watch-all -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-operator-install-watch-all-java-microprofile.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test7-bad-path-appsody-operator-install-namespace-test-java-microprofile" {
    # operator install --namespace test
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test7-bad-path-appsody-operator-install-namespace-test-java-microprofile.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test7-good-path-appsody-deploy-java-microprofile" {
    # deploy
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-java-microprofile.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody deploy --namespace test
@test "integration-operator_test7-good-path-appsody-deploy-namespace-test-java-microprofile" {
    # deploy --namespace test
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-namespace-test-java-microprofile.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test7-good-path-appsody-deploy-namespace-test2-java-microprofile" {
    # deploy --namespace test2
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-namespace-test2-java-microprofile.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test7-bad-path-appsody-operator-uninstall-java-microprofile" {
    # operator uninstall
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test7-bad-path-appsody-operator-uninstall-java-microprofile.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test7-good-path-appsody-operator-uninstall-force-java-microprofile" {
    # operator uninstall --force
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-operator-uninstall-foce-java-microprofile.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# java-microprofile test 8
#0 appsody operator install --namespace test --watch-all
@test "integration-operator_test8-good-path-appsody-operator-install-namespace-test-watch-all-java-microprofile" {
    # operator install --namespace test --watch-all
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator install --namespace test --watch-all -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-operator-install-namespace-test-watch-all-java-microprofile.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install
@test "integration-operator_test8-bad-path-appsody-operator-install-java-microprofile" {
    # operator install
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-install-java-microprofile.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test8-good-path-appsody-deploy-java-microprofile" {
    # deploy
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-java-microprofile.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test8-good-path-appsody-deploy-namespace-test-java-microprofile" {
    # deploy --namespace test
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-namespace-test-java-microprofile.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test8-good-path-appsody-deploy-namespace-test2-java-microprofile" {
    # deploy --namespace test2
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-namespace-test2-java-microprofile.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test8-bad-path-appsody-operator-uninstall-java-microprofile" {
    # operator uninstall
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-uninstall-java-microprofile.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test8-bad-path-appsody-operator-uninstall-namespace-test-java-microprofile" {
    # operator uninstall --namespace test
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-uninstall-namespace-test-java-microprofile.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test8-good-path-appsody-operator-uninstall--namespace-test-force-java-microprofile" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/java-microprofile
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-operator-uninstall-namespace-test-foce-java-microprofile.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# java-spring-boot2 test1
@test "integration-operator_test1-good-path-appsody-stack-validate-java-spring-boot2" {
    # validate
    cd $TEMPDIR/stacks/incubator/java-spring-boot2
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-stack-validate-java-spring-boot2.log
    [ "$status" -eq 0 ]
}
#0 appsody init
@test "integration-operator_test1-good-path-appsody-init-java-spring-boot2" {
    # init
    mkdir -p $TEMPDIR/java-spring-boot2
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY init -v dev.local/java-spring-boot2
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-java-spring-boot2.log
    [ "$status" -eq 0 ]
}
#0 appsody deploy
@test "integration-operator_test1-good-path-appsody-deploy-java-spring-boot2" {
    # deploy
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-deploy-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install
@test "integration-operator_test1-bad-path-appsody-operator-install-java-spring-boot2" {
    # operator install
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test1-bad-path-appsody-operator-install-java-spring-boot2.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test1-bad-path-appsody-operator-uninstall-java-spring-boot2" {
    # operator uninstall
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test1-bad-path-appsody-operator-uninstall-java-spring-boot2.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test1-good-path-appsody-operator-uninstall-force-java-spring-boot2" {
    # operator uninstall --force
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-operator-uninstall-force-java-spring-boot2.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# java-spring-boot2 test2
#0 appsody deploy --namespace test
@test "integration-operator_test2-good-path-appsody-deploy-namespace-test-java-spring-boot2" {
    # deploy --namespace test
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-deploy-namespace-test-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test2-bad-path-appsody-operator-install-namespace-test-java-spring-boot2" {
    # operator install --namespace test
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-install-namespace-test-java-spring-boot2.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test2-good-path-appsody-deploy-java-spring-boot2" {
    # deploy
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-deploy-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test2-bad-path-appsody-operator-uninstall-namespace-test-java-spring-boot2" {
    # operator uninstall --namespace test
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-uninstall-namespace-test-java-spring-boot2.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test2-bad-path-appsody-operator-uninstall-java-spring-boot2" {
    # operator uninstall
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-uninstall-java-spring-boot2.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test2-good-path-appsody-operator-uninstall--namespace-test-force-java-spring-boot2" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-operator-uninstall-namespace-test-force-java-spring-boot2.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --force
@test "integration-operator_test2-good-path-appsody-operator-uninstall-force-java-spring-boot2" {
    # operator uninstall --force
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-operator-uninstall-force-java-spring-boot2.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# java-spring-boot2 test 3
#0 appsody operator install
@test "integration-operator_test3-good-path-appsody-operator-install-java-spring-boot2" {
    # operator install
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-operator-install-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy
@test "integration-operator_test3-good-path-appsody-deploy-java-spring-boot2" {
    # deploy
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-deploy-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy delete
@test "integration-operator_test3-good-path-appsody-deploy-delete-java-spring-boot2" {
    # deploy delete
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy delete -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-deploy-delete-java-spring-boot2.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall
@test "integration-operator_test3-good-path-appsody-operator-uninstall-java-spring-boot2" {
    # operator uninstall
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-operator-uninstall-java-spring-boot2.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# java-spring-boot2 test 4
#0 appsody operator install --namespace test
@test "integration-operator_test4-good-path-appsody-operator-install-namespace-test-java-spring-boot2" {
    # operator install --namespace test
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-operator-install-namespace-test-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test4-bad-path-appsody-operator-uninstall-java-spring-boot2" {
    # operator uninstall
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test4-bad-path-appsody-operator-uninstall-java-spring-boot2.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test4-good-path-appsody-deploy-namespace-test-java-spring-boot2" {
    # deploy --namespace test
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-deploy-namespace-test-java-spring-boot2.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#1 appsody deploy delete --namespace test2
@test "integration-operator_test4-bad-path-appsody-deploy-delete-namespace-test2-java-spring-boot2" {
    # deploy delete --namespace test2
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy delete --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test4-bad-path-appsody-deploy-delete-namespace-test2-java-spring-boot2.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test4-good-path-appsody-deploy-delete-namespace-test-java-spring-boot2" {
    # deploy delete --namespace test
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-deploy-delete-namespace-test-java-spring-boot2.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --namespace test
@test "integration-operator_test4-good-path-appsody-operator-uninstall-namespace-test-java-spring-boot2" {
    # operator uninstall --namespace test
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-operator-uninstall-namespace-test-java-spring-boot2.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# java-spring-boot2 test 5
#0 appsody operator install --watchspace test
@test "integration-operator_test5-good-path-appsody-operator-install-watchspace-test-java-spring-boot2" {
    # operator install --watchspace test
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator install --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-install-watchspace-test-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test5-bad-path-appsody-operator-install-namespace-test-java-spring-boot2" {
    # operator install --namespace test
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path-appsody-operator-install-namespace-test-java-spring-boot2.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test5-good-path-appsody-deploy-namespace-test-java-spring-boot2" {
    # deploy --namespace test
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-namespace-test-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
#1 appsody deploy
@test "integration-operator_test5-bad-path-appsody-deploy-java-spring-boot2" {
    # deploy
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-java-spring-boot2.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test5-bad-path-appsody-operator-uninstall-java-spring-boot2" {
    # operator uninstall
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path-appsody-operator-uninstall-java-spring-boot2.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test5-good-path-appsody-deploy-delete-namespace-test-java-spring-boot2" {
    # deploy delete --namespace test
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-delete-namespace-test-java-spring-boot2.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall
@test "integration-operator_test5-good-path-appsody-operator-uninstall-java-spring-boot2" {
    # operator uninstall
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-uninstall-java-spring-boot2.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator install --watchspace test
@test "integration-operator_test5-good-path2-appsody-operator-install-watchspace-test-java-spring-boot2" {
    # operator install --watchspace test
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator install --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path2-appsody-operator-install-watchspace-test-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test5-good-path2-appsody-deploy-namespace-test-java-spring-boot2" {
    # deploy --namespace test
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path2-appsody-deploy-namespace-test-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test5-bad-path2-appsody-operator-uninstall-java-spring-boot2" {
    # operator uninstall
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path2-appsody-operator-uninstall-java-spring-boot2.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test5-good-path-appsody-operator-uninstall-force-java-spring-boot2" {
    # operator uninstall --force
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-uninstall-force-java-spring-boot2.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# java-spring-boot2 test 6
#0 appsody operator install --namespace test --watchspace test2
@test "integration-operator_test6-good-path-appsody-operator-install-namespace-test-watchspace-test2-java-spring-boot2" {
    # operator install --namespace test --watchspace test2
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator install --namespace test --watchspace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-install-namespace-test-watchspace-test2-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test2
@test "integration-operator_test6-bad-path-appsody-operator-install-namespace-test2-java-spring-boot2" {
    # operator install --namespace test2
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator install --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-install-namespace-test2-java-spring-boot2.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test6-good-path-appsody-deploy-namespace-test2-java-spring-boot2" {
    # deploy --namespace test2
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-deploy-namespace-test2-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
#1 appsody deploy --namespace test
@test "integration-operator_test6-bad-path-appsody-deploy-namespace-test-java-spring-boot2" {
    # deploy --namespace test
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-deploy-namespace-test-java-spring-boot2.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator install --namespace test2 --watchspace test
@test "integration-operator_test6-good-path-appsody-operator-install-namespace-test2-watchspace-test-java-spring-boot2" {
    # operator install --namespace test2 --watchspace test
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator install --namespace test2 --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-install-namespace-test2-watchspace-test-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test6-good-path-appsody-deploy-namespace-test-java-spring-boot2" {
    # deploy --namespace test
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-deploy-namespace-test-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test-java-spring-boot2" {
    # operator uninstall --namespace test
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test-java-spring-boot2.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test-force-java-spring-boot2" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test-force-java-spring-boot2.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#1 appsody operator uninstall
@test "integration-operator_test6-bad-path2-appsody-operator-uninstall-java-spring-boot2" {
    # operator uninstall
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path2-appsody-operator-uninstall-java-spring-boot2.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall --namespace test2
@test "integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test2-java-spring-boot2" {
    # operator uninstall --namespace test2
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test2-java-spring-boot2.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test6-good-path2-appsody-deploy-delete-namespace-test-java-spring-boot2" {
    # deploy delete --namespace test
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path2-appsody-deploy-delete-namespace-test-java-spring-boot2.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --namespace test2
@test "integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test2-java-spring-boot2" {
    # operator uninstall --namespace test2
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test2-java-spring-boot2.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# java-spring-boot2 test 7
#0 appsody operator install --watch-all
@test "integration-operator_test7-good-path-appsody-operator-install-watch-all-java-spring-boot2" {
    # operator install --watch-all
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator install --watch-all -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-operator-install-watch-all-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test7-bad-path-appsody-operator-install-namespace-test-java-spring-boot2" {
    # operator install --namespace test
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test7-bad-path-appsody-operator-install-namespace-test-java-spring-boot2.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test7-good-path-appsody-deploy-java-spring-boot2" {
    # deploy
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-java-spring-boot2.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody deploy --namespace test
@test "integration-operator_test7-good-path-appsody-deploy-namespace-test-java-spring-boot2" {
    # deploy --namespace test
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-namespace-test-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test7-good-path-appsody-deploy-namespace-test2-java-spring-boot2" {
    # deploy --namespace test2
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-namespace-test2-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test7-bad-path-appsody-operator-uninstall-java-spring-boot2" {
    # operator uninstall
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test7-bad-path-appsody-operator-uninstall-java-spring-boot2.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test7-good-path-appsody-operator-uninstall-force-java-spring-boot2" {
    # operator uninstall --force
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-operator-uninstall-foce-java-spring-boot2.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# java-spring-boot2 test 8
#0 appsody operator install --namespace test --watch-all
@test "integration-operator_test8-good-path-appsody-operator-install-namespace-test-watch-all-java-spring-boot2" {
    # operator install --namespace test --watch-all
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator install --namespace test --watch-all -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-operator-install-namespace-test-watch-all-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install
@test "integration-operator_test8-bad-path-appsody-operator-install-java-spring-boot2" {
    # operator install
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-install-java-spring-boot2.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test8-good-path-appsody-deploy-java-spring-boot2" {
    # deploy
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test8-good-path-appsody-deploy-namespace-test-java-spring-boot2" {
    # deploy --namespace test
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-namespace-test-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test8-good-path-appsody-deploy-namespace-test2-java-spring-boot2" {
    # deploy --namespace test2
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-namespace-test2-java-spring-boot2.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test8-bad-path-appsody-operator-uninstall-java-spring-boot2" {
    # operator uninstall
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-uninstall-java-spring-boot2.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test8-bad-path-appsody-operator-uninstall-namespace-test-java-spring-boot2" {
    # operator uninstall --namespace test
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-uninstall-namespace-test-java-spring-boot2.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test8-good-path-appsody-operator-uninstall--namespace-test-force-java-spring-boot2" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/java-spring-boot2
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-operator-uninstall-namespace-test-foce-java-spring-boot2.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# python-flask test1
@test "integration-operator_test1-good-path-appsody-stack-validate-python-flask" {
    # validate
    cd $TEMPDIR/stacks/incubator/python-flask
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-stack-validate-python-flask.log
    [ "$status" -eq 0 ]
}
#0 appsody init
@test "integration-operator_test1-good-path-appsody-init-python-flask" {
    # init
    mkdir -p $TEMPDIR/python-flask
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY init -v dev.local/python-flask
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-python-flask.log
    [ "$status" -eq 0 ]
}
#0 appsody deploy
@test "integration-operator_test1-good-path-appsody-deploy-python-flask" {
    # deploy
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-deploy-python-flask.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install
@test "integration-operator_test1-bad-path-appsody-operator-install-python-flask" {
    # operator install
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test1-bad-path-appsody-operator-install-python-flask.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test1-bad-path-appsody-operator-uninstall-python-flask" {
    # operator uninstall
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test1-bad-path-appsody-operator-uninstall-python-flask.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test1-good-path-appsody-operator-uninstall-force-python-flask" {
    # operator uninstall --force
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-operator-uninstall-force-python-flask.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# python-flask test2
#0 appsody deploy --namespace test
@test "integration-operator_test2-good-path-appsody-deploy-namespace-test-python-flask" {
    # deploy --namespace test
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-deploy-namespace-test-python-flask.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test2-bad-path-appsody-operator-install-namespace-test-python-flask" {
    # operator install --namespace test
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-install-namespace-test-python-flask.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test2-good-path-appsody-deploy-python-flask" {
    # deploy
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-deploy-python-flask.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test2-bad-path-appsody-operator-uninstall-namespace-test-python-flask" {
    # operator uninstall --namespace test
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-uninstall-namespace-test-python-flask.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test2-bad-path-appsody-operator-uninstall-python-flask" {
    # operator uninstall
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-uninstall-python-flask.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test2-good-path-appsody-operator-uninstall--namespace-test-force-python-flask" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-operator-uninstall-namespace-test-force-python-flask.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --force
@test "integration-operator_test2-good-path-appsody-operator-uninstall-force-python-flask" {
    # operator uninstall --force
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-operator-uninstall-force-python-flask.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# python-flask test 3
#0 appsody operator install
@test "integration-operator_test3-good-path-appsody-operator-install-python-flask" {
    # operator install
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-operator-install-python-flask.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy
@test "integration-operator_test3-good-path-appsody-deploy-python-flask" {
    # deploy
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-deploy-python-flask.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy delete
@test "integration-operator_test3-good-path-appsody-deploy-delete-python-flask" {
    # deploy delete
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy delete -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-deploy-delete-python-flask.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall
@test "integration-operator_test3-good-path-appsody-operator-uninstall-python-flask" {
    # operator uninstall
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-operator-uninstall-python-flask.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# python-flask test 4
#0 appsody operator install --namespace test
@test "integration-operator_test4-good-path-appsody-operator-install-namespace-test-python-flask" {
    # operator install --namespace test
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-operator-install-namespace-test-python-flask.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test4-bad-path-appsody-operator-uninstall-python-flask" {
    # operator uninstall
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test4-bad-path-appsody-operator-uninstall-python-flask.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test4-good-path-appsody-deploy-namespace-test-python-flask" {
    # deploy --namespace test
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-deploy-namespace-test-python-flask.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#1 appsody deploy delete --namespace test2
@test "integration-operator_test4-bad-path-appsody-deploy-delete-namespace-test2-python-flask" {
    # deploy delete --namespace test2
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy delete --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test4-bad-path-appsody-deploy-delete-namespace-test2-python-flask.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test4-good-path-appsody-deploy-delete-namespace-test-python-flask" {
    # deploy delete --namespace test
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-deploy-delete-namespace-test-python-flask.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --namespace test
@test "integration-operator_test4-good-path-appsody-operator-uninstall-namespace-test-python-flask" {
    # operator uninstall --namespace test
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-operator-uninstall-namespace-test-python-flask.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# python-flask test 5
#0 appsody operator install --watchspace test
@test "integration-operator_test5-good-path-appsody-operator-install-watchspace-test-python-flask" {
    # operator install --watchspace test
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator install --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-install-watchspace-test-python-flask.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test5-bad-path-appsody-operator-install-namespace-test-python-flask" {
    # operator install --namespace test
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path-appsody-operator-install-namespace-test-python-flask.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test5-good-path-appsody-deploy-namespace-test-python-flask" {
    # deploy --namespace test
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-namespace-test-python-flask.log
    [ "$status" -eq 0 ]  
}
#1 appsody deploy
@test "integration-operator_test5-bad-path-appsody-deploy-python-flask" {
    # deploy
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-python-flask.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test5-bad-path-appsody-operator-uninstall-python-flask" {
    # operator uninstall
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path-appsody-operator-uninstall-python-flask.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test5-good-path-appsody-deploy-delete-namespace-test-python-flask" {
    # deploy delete --namespace test
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-delete-namespace-test-python-flask.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall
@test "integration-operator_test5-good-path-appsody-operator-uninstall-python-flask" {
    # operator uninstall
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-uninstall-python-flask.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator install --watchspace test
@test "integration-operator_test5-good-path2-appsody-operator-install-watchspace-test-python-flask" {
    # operator install --watchspace test
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator install --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path2-appsody-operator-install-watchspace-test-python-flask.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test5-good-path2-appsody-deploy-namespace-test-python-flask" {
    # deploy --namespace test
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path2-appsody-deploy-namespace-test-python-flask.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test5-bad-path2-appsody-operator-uninstall-python-flask" {
    # operator uninstall
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path2-appsody-operator-uninstall-python-flask.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test5-good-path-appsody-operator-uninstall-force-python-flask" {
    # operator uninstall --force
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-uninstall-force-python-flask.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# python-flask test 6
#0 appsody operator install --namespace test --watchspace test2
@test "integration-operator_test6-good-path-appsody-operator-install-namespace-test-watchspace-test2-python-flask" {
    # operator install --namespace test --watchspace test2
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator install --namespace test --watchspace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-install-namespace-test-watchspace-test2-python-flask.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test2
@test "integration-operator_test6-bad-path-appsody-operator-install-namespace-test2-python-flask" {
    # operator install --namespace test2
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator install --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-install-namespace-test2-python-flask.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test6-good-path-appsody-deploy-namespace-test2-python-flask" {
    # deploy --namespace test2
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-deploy-namespace-test2-python-flask.log
    [ "$status" -eq 0 ]  
}
#1 appsody deploy --namespace test
@test "integration-operator_test6-bad-path-appsody-deploy-namespace-test-python-flask" {
    # deploy --namespace test
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-deploy-namespace-test-python-flask.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator install --namespace test2 --watchspace test
@test "integration-operator_test6-good-path-appsody-operator-install-namespace-test2-watchspace-test-python-flask" {
    # operator install --namespace test2 --watchspace test
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator install --namespace test2 --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-install-namespace-test2-watchspace-test-python-flask.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test6-good-path-appsody-deploy-namespace-test-python-flask" {
    # deploy --namespace test
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-deploy-namespace-test-python-flask.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test-python-flask" {
    # operator uninstall --namespace test
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test-python-flask.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test-force-python-flask" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test-force-python-flask.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#1 appsody operator uninstall
@test "integration-operator_test6-bad-path2-appsody-operator-uninstall-python-flask" {
    # operator uninstall
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path2-appsody-operator-uninstall-python-flask.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall --namespace test2
@test "integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test2-python-flask" {
    # operator uninstall --namespace test2
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test2-python-flask.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test6-good-path2-appsody-deploy-delete-namespace-test-python-flask" {
    # deploy delete --namespace test
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path2-appsody-deploy-delete-namespace-test-python-flask.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --namespace test2
@test "integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test2-python-flask" {
    # operator uninstall --namespace test2
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test2-python-flask.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# python-flask test 7
#0 appsody operator install --watch-all
@test "integration-operator_test7-good-path-appsody-operator-install-watch-all-python-flask" {
    # operator install --watch-all
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator install --watch-all -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-operator-install-watch-all-python-flask.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test7-bad-path-appsody-operator-install-namespace-test-python-flask" {
    # operator install --namespace test
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test7-bad-path-appsody-operator-install-namespace-test-python-flask.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test7-good-path-appsody-deploy-python-flask" {
    # deploy
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-python-flask.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody deploy --namespace test
@test "integration-operator_test7-good-path-appsody-deploy-namespace-test-python-flask" {
    # deploy --namespace test
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-namespace-test-python-flask.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test7-good-path-appsody-deploy-namespace-test2-python-flask" {
    # deploy --namespace test2
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-namespace-test2-python-flask.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test7-bad-path-appsody-operator-uninstall-python-flask" {
    # operator uninstall
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test7-bad-path-appsody-operator-uninstall-python-flask.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test7-good-path-appsody-operator-uninstall-force-python-flask" {
    # operator uninstall --force
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-operator-uninstall-foce-python-flask.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# python-flask test 8
#0 appsody operator install --namespace test --watch-all
@test "integration-operator_test8-good-path-appsody-operator-install-namespace-test-watch-all-python-flask" {
    # operator install --namespace test --watch-all
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator install --namespace test --watch-all -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-operator-install-namespace-test-watch-all-python-flask.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install
@test "integration-operator_test8-bad-path-appsody-operator-install-python-flask" {
    # operator install
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-install-python-flask.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test8-good-path-appsody-deploy-python-flask" {
    # deploy
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-python-flask.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test8-good-path-appsody-deploy-namespace-test-python-flask" {
    # deploy --namespace test
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-namespace-test-python-flask.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test8-good-path-appsody-deploy-namespace-test2-python-flask" {
    # deploy --namespace test2
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-namespace-test2-python-flask.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test8-bad-path-appsody-operator-uninstall-python-flask" {
    # operator uninstall
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-uninstall-python-flask.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test8-bad-path-appsody-operator-uninstall-namespace-test-python-flask" {
    # operator uninstall --namespace test
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-uninstall-namespace-test-python-flask.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test8-good-path-appsody-operator-uninstall--namespace-test-force-python-flask" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/python-flask
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-operator-uninstall-namespace-test-foce-python-flask.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# swift test1
@test "integration-operator_test1-good-path-appsody-stack-validate-swift" {
    # validate
    cd $TEMPDIR/stacks/incubator/swift
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-stack-validate-swift.log
    [ "$status" -eq 0 ]
}
#0 appsody init
@test "integration-operator_test1-good-path-appsody-init-swift" {
    # init
    mkdir -p $TEMPDIR/swift
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY init -v dev.local/swift
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-swift.log
    [ "$status" -eq 0 ]
}
#0 appsody deploy
@test "integration-operator_test1-good-path-appsody-deploy-swift" {
    # deploy
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-deploy-swift.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install
@test "integration-operator_test1-bad-path-appsody-operator-install-swift" {
    # operator install
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test1-bad-path-appsody-operator-install-swift.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test1-bad-path-appsody-operator-uninstall-swift" {
    # operator uninstall
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test1-bad-path-appsody-operator-uninstall-swift.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test1-good-path-appsody-operator-uninstall-force-swift" {
    # operator uninstall --force
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-operator-uninstall-force-swift.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# swift test2
#0 appsody deploy --namespace test
@test "integration-operator_test2-good-path-appsody-deploy-namespace-test-swift" {
    # deploy --namespace test
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-deploy-namespace-test-swift.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test2-bad-path-appsody-operator-install-namespace-test-swift" {
    # operator install --namespace test
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-install-namespace-test-swift.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test2-good-path-appsody-deploy-swift" {
    # deploy
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-deploy-swift.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test2-bad-path-appsody-operator-uninstall-namespace-test-swift" {
    # operator uninstall --namespace test
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-uninstall-namespace-test-swift.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test2-bad-path-appsody-operator-uninstall-swift" {
    # operator uninstall
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-uninstall-swift.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test2-good-path-appsody-operator-uninstall--namespace-test-force-swift" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-operator-uninstall-namespace-test-force-swift.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --force
@test "integration-operator_test2-good-path-appsody-operator-uninstall-force-swift" {
    # operator uninstall --force
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-operator-uninstall-force-swift.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# swift test 3
#0 appsody operator install
@test "integration-operator_test3-good-path-appsody-operator-install-swift" {
    # operator install
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-operator-install-swift.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy
@test "integration-operator_test3-good-path-appsody-deploy-swift" {
    # deploy
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-deploy-swift.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy delete
@test "integration-operator_test3-good-path-appsody-deploy-delete-swift" {
    # deploy delete
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy delete -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-deploy-delete-swift.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall
@test "integration-operator_test3-good-path-appsody-operator-uninstall-swift" {
    # operator uninstall
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-operator-uninstall-swift.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# swift test 4
#0 appsody operator install --namespace test
@test "integration-operator_test4-good-path-appsody-operator-install-namespace-test-swift" {
    # operator install --namespace test
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-operator-install-namespace-test-swift.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test4-bad-path-appsody-operator-uninstall-swift" {
    # operator uninstall
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test4-bad-path-appsody-operator-uninstall-swift.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test4-good-path-appsody-deploy-namespace-test-swift" {
    # deploy --namespace test
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-deploy-namespace-test-swift.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#1 appsody deploy delete --namespace test2
@test "integration-operator_test4-bad-path-appsody-deploy-delete-namespace-test2-swift" {
    # deploy delete --namespace test2
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy delete --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test4-bad-path-appsody-deploy-delete-namespace-test2-swift.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test4-good-path-appsody-deploy-delete-namespace-test-swift" {
    # deploy delete --namespace test
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-deploy-delete-namespace-test-swift.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --namespace test
@test "integration-operator_test4-good-path-appsody-operator-uninstall-namespace-test-swift" {
    # operator uninstall --namespace test
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-operator-uninstall-namespace-test-swift.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# swift test 5
#0 appsody operator install --watchspace test
@test "integration-operator_test5-good-path-appsody-operator-install-watchspace-test-swift" {
    # operator install --watchspace test
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator install --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-install-watchspace-test-swift.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test5-bad-path-appsody-operator-install-namespace-test-swift" {
    # operator install --namespace test
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path-appsody-operator-install-namespace-test-swift.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test5-good-path-appsody-deploy-namespace-test-swift" {
    # deploy --namespace test
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-namespace-test-swift.log
    [ "$status" -eq 0 ]  
}
#1 appsody deploy
@test "integration-operator_test5-bad-path-appsody-deploy-swift" {
    # deploy
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-swift.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test5-bad-path-appsody-operator-uninstall-swift" {
    # operator uninstall
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path-appsody-operator-uninstall-swift.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test5-good-path-appsody-deploy-delete-namespace-test-swift" {
    # deploy delete --namespace test
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-delete-namespace-test-swift.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall
@test "integration-operator_test5-good-path-appsody-operator-uninstall-swift" {
    # operator uninstall
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-uninstall-swift.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator install --watchspace test
@test "integration-operator_test5-good-path2-appsody-operator-install-watchspace-test-swift" {
    # operator install --watchspace test
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator install --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path2-appsody-operator-install-watchspace-test-swift.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test5-good-path2-appsody-deploy-namespace-test-swift" {
    # deploy --namespace test
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path2-appsody-deploy-namespace-test-swift.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test5-bad-path2-appsody-operator-uninstall-swift" {
    # operator uninstall
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path2-appsody-operator-uninstall-swift.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test5-good-path-appsody-operator-uninstall-force-swift" {
    # operator uninstall --force
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-uninstall-force-swift.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# swift test 6
#0 appsody operator install --namespace test --watchspace test2
@test "integration-operator_test6-good-path-appsody-operator-install-namespace-test-watchspace-test2-swift" {
    # operator install --namespace test --watchspace test2
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator install --namespace test --watchspace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-install-namespace-test-watchspace-test2-swift.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test2
@test "integration-operator_test6-bad-path-appsody-operator-install-namespace-test2-swift" {
    # operator install --namespace test2
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator install --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-install-namespace-test2-swift.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test6-good-path-appsody-deploy-namespace-test2-swift" {
    # deploy --namespace test2
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-deploy-namespace-test2-swift.log
    [ "$status" -eq 0 ]  
}
#1 appsody deploy --namespace test
@test "integration-operator_test6-bad-path-appsody-deploy-namespace-test-swift" {
    # deploy --namespace test
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-deploy-namespace-test-swift.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator install --namespace test2 --watchspace test
@test "integration-operator_test6-good-path-appsody-operator-install-namespace-test2-watchspace-test-swift" {
    # operator install --namespace test2 --watchspace test
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator install --namespace test2 --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-install-namespace-test2-watchspace-test-swift.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test6-good-path-appsody-deploy-namespace-test-swift" {
    # deploy --namespace test
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-deploy-namespace-test-swift.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test-swift" {
    # operator uninstall --namespace test
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test-swift.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test-force-swift" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test-force-swift.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#1 appsody operator uninstall
@test "integration-operator_test6-bad-path2-appsody-operator-uninstall-swift" {
    # operator uninstall
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path2-appsody-operator-uninstall-swift.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall --namespace test2
@test "integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test2-swift" {
    # operator uninstall --namespace test2
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test2-swift.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test6-good-path2-appsody-deploy-delete-namespace-test-swift" {
    # deploy delete --namespace test
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path2-appsody-deploy-delete-namespace-test-swift.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --namespace test2
@test "integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test2-swift" {
    # operator uninstall --namespace test2
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test2-swift.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# swift test 7
#0 appsody operator install --watch-all
@test "integration-operator_test7-good-path-appsody-operator-install-watch-all-swift" {
    # operator install --watch-all
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator install --watch-all -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-operator-install-watch-all-swift.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test7-bad-path-appsody-operator-install-namespace-test-swift" {
    # operator install --namespace test
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test7-bad-path-appsody-operator-install-namespace-test-swift.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test7-good-path-appsody-deploy-swift" {
    # deploy
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-swift.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody deploy --namespace test
@test "integration-operator_test7-good-path-appsody-deploy-namespace-test-swift" {
    # deploy --namespace test
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-namespace-test-swift.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test7-good-path-appsody-deploy-namespace-test2-swift" {
    # deploy --namespace test2
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-namespace-test2-swift.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test7-bad-path-appsody-operator-uninstall-swift" {
    # operator uninstall
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test7-bad-path-appsody-operator-uninstall-swift.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test7-good-path-appsody-operator-uninstall-force-swift" {
    # operator uninstall --force
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-operator-uninstall-foce-swift.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# swift test 8
#0 appsody operator install --namespace test --watch-all
@test "integration-operator_test8-good-path-appsody-operator-install-namespace-test-watch-all-swift" {
    # operator install --namespace test --watch-all
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator install --namespace test --watch-all -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-operator-install-namespace-test-watch-all-swift.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install
@test "integration-operator_test8-bad-path-appsody-operator-install-swift" {
    # operator install
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-install-swift.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test8-good-path-appsody-deploy-swift" {
    # deploy
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-swift.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test8-good-path-appsody-deploy-namespace-test-swift" {
    # deploy --namespace test
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-namespace-test-swift.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test8-good-path-appsody-deploy-namespace-test2-swift" {
    # deploy --namespace test2
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-namespace-test2-swift.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test8-bad-path-appsody-operator-uninstall-swift" {
    # operator uninstall
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-uninstall-swift.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test8-bad-path-appsody-operator-uninstall-namespace-test-swift" {
    # operator uninstall --namespace test
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-uninstall-namespace-test-swift.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test8-good-path-appsody-operator-uninstall--namespace-test-force-swift" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/swift
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-operator-uninstall-namespace-test-foce-swift.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# kitura test1
@test "integration-operator_test1-good-path-appsody-stack-validate-kitura" {
    # validate
    cd $TEMPDIR/stacks/incubator/kitura
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-stack-validate-kitura.log
    [ "$status" -eq 0 ]
}
#0 appsody init
@test "integration-operator_test1-good-path-appsody-init-kitura" {
    # init
    mkdir -p $TEMPDIR/kitura
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY init -v dev.local/kitura
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-kitura.log
    [ "$status" -eq 0 ]
}
#0 appsody deploy
@test "integration-operator_test1-good-path-appsody-deploy-kitura" {
    # deploy
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-deploy-kitura.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install
@test "integration-operator_test1-bad-path-appsody-operator-install-kitura" {
    # operator install
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test1-bad-path-appsody-operator-install-kitura.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test1-bad-path-appsody-operator-uninstall-kitura" {
    # operator uninstall
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test1-bad-path-appsody-operator-uninstall-kitura.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test1-good-path-appsody-operator-uninstall-force-kitura" {
    # operator uninstall --force
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-operator-uninstall-force-kitura.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# kitura test2
#0 appsody deploy --namespace test
@test "integration-operator_test2-good-path-appsody-deploy-namespace-test-kitura" {
    # deploy --namespace test
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-deploy-namespace-test-kitura.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test2-bad-path-appsody-operator-install-namespace-test-kitura" {
    # operator install --namespace test
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-install-namespace-test-kitura.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test2-good-path-appsody-deploy-kitura" {
    # deploy
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-deploy-kitura.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test2-bad-path-appsody-operator-uninstall-namespace-test-kitura" {
    # operator uninstall --namespace test
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-uninstall-namespace-test-kitura.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test2-bad-path-appsody-operator-uninstall-kitura" {
    # operator uninstall
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-uninstall-kitura.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test2-good-path-appsody-operator-uninstall--namespace-test-force-kitura" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-operator-uninstall-namespace-test-force-kitura.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --force
@test "integration-operator_test2-good-path-appsody-operator-uninstall-force-kitura" {
    # operator uninstall --force
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-operator-uninstall-force-kitura.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# kitura test 3
#0 appsody operator install
@test "integration-operator_test3-good-path-appsody-operator-install-kitura" {
    # operator install
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-operator-install-kitura.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy
@test "integration-operator_test3-good-path-appsody-deploy-kitura" {
    # deploy
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-deploy-kitura.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy delete
@test "integration-operator_test3-good-path-appsody-deploy-delete-kitura" {
    # deploy delete
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy delete -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-deploy-delete-kitura.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall
@test "integration-operator_test3-good-path-appsody-operator-uninstall-kitura" {
    # operator uninstall
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-operator-uninstall-kitura.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# kitura test 4
#0 appsody operator install --namespace test
@test "integration-operator_test4-good-path-appsody-operator-install-namespace-test-kitura" {
    # operator install --namespace test
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-operator-install-namespace-test-kitura.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test4-bad-path-appsody-operator-uninstall-kitura" {
    # operator uninstall
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test4-bad-path-appsody-operator-uninstall-kitura.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test4-good-path-appsody-deploy-namespace-test-kitura" {
    # deploy --namespace test
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-deploy-namespace-test-kitura.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#1 appsody deploy delete --namespace test2
@test "integration-operator_test4-bad-path-appsody-deploy-delete-namespace-test2-kitura" {
    # deploy delete --namespace test2
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy delete --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test4-bad-path-appsody-deploy-delete-namespace-test2-kitura.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test4-good-path-appsody-deploy-delete-namespace-test-kitura" {
    # deploy delete --namespace test
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-deploy-delete-namespace-test-kitura.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --namespace test
@test "integration-operator_test4-good-path-appsody-operator-uninstall-namespace-test-kitura" {
    # operator uninstall --namespace test
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-operator-uninstall-namespace-test-kitura.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# kitura test 5
#0 appsody operator install --watchspace test
@test "integration-operator_test5-good-path-appsody-operator-install-watchspace-test-kitura" {
    # operator install --watchspace test
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator install --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-install-watchspace-test-kitura.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test5-bad-path-appsody-operator-install-namespace-test-kitura" {
    # operator install --namespace test
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path-appsody-operator-install-namespace-test-kitura.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test5-good-path-appsody-deploy-namespace-test-kitura" {
    # deploy --namespace test
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-namespace-test-kitura.log
    [ "$status" -eq 0 ]  
}
#1 appsody deploy
@test "integration-operator_test5-bad-path-appsody-deploy-kitura" {
    # deploy
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-kitura.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test5-bad-path-appsody-operator-uninstall-kitura" {
    # operator uninstall
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path-appsody-operator-uninstall-kitura.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test5-good-path-appsody-deploy-delete-namespace-test-kitura" {
    # deploy delete --namespace test
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-delete-namespace-test-kitura.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall
@test "integration-operator_test5-good-path-appsody-operator-uninstall-kitura" {
    # operator uninstall
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-uninstall-kitura.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator install --watchspace test
@test "integration-operator_test5-good-path2-appsody-operator-install-watchspace-test-kitura" {
    # operator install --watchspace test
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator install --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path2-appsody-operator-install-watchspace-test-kitura.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test5-good-path2-appsody-deploy-namespace-test-kitura" {
    # deploy --namespace test
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path2-appsody-deploy-namespace-test-kitura.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test5-bad-path2-appsody-operator-uninstall-kitura" {
    # operator uninstall
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path2-appsody-operator-uninstall-kitura.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test5-good-path-appsody-operator-uninstall-force-kitura" {
    # operator uninstall --force
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-uninstall-force-kitura.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# kitura test 6
#0 appsody operator install --namespace test --watchspace test2
@test "integration-operator_test6-good-path-appsody-operator-install-namespace-test-watchspace-test2-kitura" {
    # operator install --namespace test --watchspace test2
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator install --namespace test --watchspace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-install-namespace-test-watchspace-test2-kitura.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test2
@test "integration-operator_test6-bad-path-appsody-operator-install-namespace-test2-kitura" {
    # operator install --namespace test2
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator install --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-install-namespace-test2-kitura.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test6-good-path-appsody-deploy-namespace-test2-kitura" {
    # deploy --namespace test2
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-deploy-namespace-test2-kitura.log
    [ "$status" -eq 0 ]  
}
#1 appsody deploy --namespace test
@test "integration-operator_test6-bad-path-appsody-deploy-namespace-test-kitura" {
    # deploy --namespace test
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-deploy-namespace-test-kitura.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator install --namespace test2 --watchspace test
@test "integration-operator_test6-good-path-appsody-operator-install-namespace-test2-watchspace-test-kitura" {
    # operator install --namespace test2 --watchspace test
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator install --namespace test2 --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-install-namespace-test2-watchspace-test-kitura.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test6-good-path-appsody-deploy-namespace-test-kitura" {
    # deploy --namespace test
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-deploy-namespace-test-kitura.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test-kitura" {
    # operator uninstall --namespace test
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test-kitura.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test-force-kitura" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test-force-kitura.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#1 appsody operator uninstall
@test "integration-operator_test6-bad-path2-appsody-operator-uninstall-kitura" {
    # operator uninstall
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path2-appsody-operator-uninstall-kitura.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall --namespace test2
@test "integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test2-kitura" {
    # operator uninstall --namespace test2
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test2-kitura.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test6-good-path2-appsody-deploy-delete-namespace-test-kitura" {
    # deploy delete --namespace test
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path2-appsody-deploy-delete-namespace-test-kitura.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --namespace test2
@test "integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test2-kitura" {
    # operator uninstall --namespace test2
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test2-kitura.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# kitura test 7
#0 appsody operator install --watch-all
@test "integration-operator_test7-good-path-appsody-operator-install-watch-all-kitura" {
    # operator install --watch-all
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator install --watch-all -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-operator-install-watch-all-kitura.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test7-bad-path-appsody-operator-install-namespace-test-kitura" {
    # operator install --namespace test
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test7-bad-path-appsody-operator-install-namespace-test-kitura.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test7-good-path-appsody-deploy-kitura" {
    # deploy
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-kitura.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody deploy --namespace test
@test "integration-operator_test7-good-path-appsody-deploy-namespace-test-kitura" {
    # deploy --namespace test
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-namespace-test-kitura.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test7-good-path-appsody-deploy-namespace-test2-kitura" {
    # deploy --namespace test2
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-namespace-test2-kitura.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test7-bad-path-appsody-operator-uninstall-kitura" {
    # operator uninstall
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test7-bad-path-appsody-operator-uninstall-kitura.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test7-good-path-appsody-operator-uninstall-force-kitura" {
    # operator uninstall --force
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-operator-uninstall-foce-kitura.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# kitura test 8
#0 appsody operator install --namespace test --watch-all
@test "integration-operator_test8-good-path-appsody-operator-install-namespace-test-watch-all-kitura" {
    # operator install --namespace test --watch-all
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator install --namespace test --watch-all -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-operator-install-namespace-test-watch-all-kitura.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install
@test "integration-operator_test8-bad-path-appsody-operator-install-kitura" {
    # operator install
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-install-kitura.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test8-good-path-appsody-deploy-kitura" {
    # deploy
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-kitura.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test8-good-path-appsody-deploy-namespace-test-kitura" {
    # deploy --namespace test
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-namespace-test-kitura.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test8-good-path-appsody-deploy-namespace-test2-kitura" {
    # deploy --namespace test2
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-namespace-test2-kitura.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test8-bad-path-appsody-operator-uninstall-kitura" {
    # operator uninstall
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-uninstall-kitura.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test8-bad-path-appsody-operator-uninstall-namespace-test-kitura" {
    # operator uninstall --namespace test
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-uninstall-namespace-test-kitura.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test8-good-path-appsody-operator-uninstall--namespace-test-force-kitura" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/kitura
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-operator-uninstall-namespace-test-foce-kitura.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# starter test1
@test "integration-operator_test1-good-path-appsody-stack-validate-starter" {
    # validate
    cd $TEMPDIR/stacks/incubator/starter
    run timeout 1h $APPSODY stack validate -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-stack-validate-starter.log
    [ "$status" -eq 0 ]
}
#0 appsody init
@test "integration-operator_test1-good-path-appsody-init-starter" {
    # init
    mkdir -p $TEMPDIR/starter
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY init -v dev.local/starter
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-starter.log
    [ "$status" -eq 0 ]
}
#0 appsody deploy
@test "integration-operator_test1-good-path-appsody-deploy-starter" {
    # deploy
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-deploy-starter.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install
@test "integration-operator_test1-bad-path-appsody-operator-install-starter" {
    # operator install
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test1-bad-path-appsody-operator-install-starter.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test1-bad-path-appsody-operator-uninstall-starter" {
    # operator uninstall
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test1-bad-path-appsody-operator-uninstall-starter.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test1-good-path-appsody-operator-uninstall-force-starter" {
    # operator uninstall --force
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test1-good-path-appsody-operator-uninstall-force-starter.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# starter test2
#0 appsody deploy --namespace test
@test "integration-operator_test2-good-path-appsody-deploy-namespace-test-starter" {
    # deploy --namespace test
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-deploy-namespace-test-starter.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test2-bad-path-appsody-operator-install-namespace-test-starter" {
    # operator install --namespace test
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-install-namespace-test-starter.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test2-good-path-appsody-deploy-starter" {
    # deploy
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-deploy-starter.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test2-bad-path-appsody-operator-uninstall-namespace-test-starter" {
    # operator uninstall --namespace test
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-uninstall-namespace-test-starter.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test2-bad-path-appsody-operator-uninstall-starter" {
    # operator uninstall
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-uninstall-starter.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test2-good-path-appsody-operator-uninstall--namespace-test-force-starter" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-operator-uninstall-namespace-test-force-starter.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --force
@test "integration-operator_test2-good-path-appsody-operator-uninstall-force-starter" {
    # operator uninstall --force
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-operator-uninstall-force-starter.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# starter test 3
#0 appsody operator install
@test "integration-operator_test3-good-path-appsody-operator-install-starter" {
    # operator install
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-operator-install-starter.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy
@test "integration-operator_test3-good-path-appsody-deploy-starter" {
    # deploy
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-deploy-starter.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy delete
@test "integration-operator_test3-good-path-appsody-deploy-delete-starter" {
    # deploy delete
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy delete -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-deploy-delete-starter.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall
@test "integration-operator_test3-good-path-appsody-operator-uninstall-starter" {
    # operator uninstall
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-operator-uninstall-starter.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# starter test 4
#0 appsody operator install --namespace test
@test "integration-operator_test4-good-path-appsody-operator-install-namespace-test-starter" {
    # operator install --namespace test
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-operator-install-namespace-test-starter.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test4-bad-path-appsody-operator-uninstall-starter" {
    # operator uninstall
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test4-bad-path-appsody-operator-uninstall-starter.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test4-good-path-appsody-deploy-namespace-test-starter" {
    # deploy --namespace test
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-deploy-namespace-test-starter.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#1 appsody deploy delete --namespace test2
@test "integration-operator_test4-bad-path-appsody-deploy-delete-namespace-test2-starter" {
    # deploy delete --namespace test2
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy delete --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test4-bad-path-appsody-deploy-delete-namespace-test2-starter.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test4-good-path-appsody-deploy-delete-namespace-test-starter" {
    # deploy delete --namespace test
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-deploy-delete-namespace-test-starter.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --namespace test
@test "integration-operator_test4-good-path-appsody-operator-uninstall-namespace-test-starter" {
    # operator uninstall --namespace test
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-operator-uninstall-namespace-test-starter.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# starter test 5
#0 appsody operator install --watchspace test
@test "integration-operator_test5-good-path-appsody-operator-install-watchspace-test-starter" {
    # operator install --watchspace test
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator install --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-install-watchspace-test-starter.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test5-bad-path-appsody-operator-install-namespace-test-starter" {
    # operator install --namespace test
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path-appsody-operator-install-namespace-test-starter.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test5-good-path-appsody-deploy-namespace-test-starter" {
    # deploy --namespace test
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-namespace-test-starter.log
    [ "$status" -eq 0 ]  
}
#1 appsody deploy
@test "integration-operator_test5-bad-path-appsody-deploy-starter" {
    # deploy
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-starter.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test5-bad-path-appsody-operator-uninstall-starter" {
    # operator uninstall
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path-appsody-operator-uninstall-starter.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test5-good-path-appsody-deploy-delete-namespace-test-starter" {
    # deploy delete --namespace test
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-deploy-delete-namespace-test-starter.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall
@test "integration-operator_test5-good-path-appsody-operator-uninstall-starter" {
    # operator uninstall
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-uninstall-starter.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator install --watchspace test
@test "integration-operator_test5-good-path2-appsody-operator-install-watchspace-test-starter" {
    # operator install --watchspace test
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator install --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path2-appsody-operator-install-watchspace-test-starter.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test5-good-path2-appsody-deploy-namespace-test-starter" {
    # deploy --namespace test
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path2-appsody-deploy-namespace-test-starter.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test5-bad-path2-appsody-operator-uninstall-starter" {
    # operator uninstall
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-bad-path2-appsody-operator-uninstall-starter.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test5-good-path-appsody-operator-uninstall-force-starter" {
    # operator uninstall --force
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-uninstall-force-starter.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# starter test 6
#0 appsody operator install --namespace test --watchspace test2
@test "integration-operator_test6-good-path-appsody-operator-install-namespace-test-watchspace-test2-starter" {
    # operator install --namespace test --watchspace test2
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator install --namespace test --watchspace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-install-namespace-test-watchspace-test2-starter.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test2
@test "integration-operator_test6-bad-path-appsody-operator-install-namespace-test2-starter" {
    # operator install --namespace test2
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator install --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-install-namespace-test2-starter.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test6-good-path-appsody-deploy-namespace-test2-starter" {
    # deploy --namespace test2
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-deploy-namespace-test2-starter.log
    [ "$status" -eq 0 ]  
}
#1 appsody deploy --namespace test
@test "integration-operator_test6-bad-path-appsody-deploy-namespace-test-starter" {
    # deploy --namespace test
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-deploy-namespace-test-starter.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator install --namespace test2 --watchspace test
@test "integration-operator_test6-good-path-appsody-operator-install-namespace-test2-watchspace-test-starter" {
    # operator install --namespace test2 --watchspace test
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator install --namespace test2 --watchspace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-install-namespace-test2-watchspace-test-starter.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test6-good-path-appsody-deploy-namespace-test-starter" {
    # deploy --namespace test
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-deploy-namespace-test-starter.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test-starter" {
    # operator uninstall --namespace test
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test-starter.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test-force-starter" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test-force-starter.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#1 appsody operator uninstall
@test "integration-operator_test6-bad-path2-appsody-operator-uninstall-starter" {
    # operator uninstall
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path2-appsody-operator-uninstall-starter.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall --namespace test2
@test "integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test2-starter" {
    # operator uninstall --namespace test2
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-bad-path-appsody-operator-uninstall-namespace-test2-starter.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy delete --namespace test
@test "integration-operator_test6-good-path2-appsody-deploy-delete-namespace-test-starter" {
    # deploy delete --namespace test
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy delete --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path2-appsody-deploy-delete-namespace-test-starter.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody operator uninstall --namespace test2
@test "integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test2-starter" {
    # operator uninstall --namespace test2
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test2-starter.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# starter test 7
#0 appsody operator install --watch-all
@test "integration-operator_test7-good-path-appsody-operator-install-watch-all-starter" {
    # operator install --watch-all
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator install --watch-all -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-operator-install-watch-all-starter.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install --namespace test
@test "integration-operator_test7-bad-path-appsody-operator-install-namespace-test-starter" {
    # operator install --namespace test
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test7-bad-path-appsody-operator-install-namespace-test-starter.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test7-good-path-appsody-deploy-starter" {
    # deploy
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-starter.log
    [ "$status" -eq 0 ]  
    sleep 20
}
#0 appsody deploy --namespace test
@test "integration-operator_test7-good-path-appsody-deploy-namespace-test-starter" {
    # deploy --namespace test
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-namespace-test-starter.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test7-good-path-appsody-deploy-namespace-test2-starter" {
    # deploy --namespace test2
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-deploy-namespace-test2-starter.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test7-bad-path-appsody-operator-uninstall-starter" {
    # operator uninstall
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test7-bad-path-appsody-operator-uninstall-starter.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --force
@test "integration-operator_test7-good-path-appsody-operator-uninstall-force-starter" {
    # operator uninstall --force
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test7-good-path-appsody-operator-uninstall-foce-starter.log
    [ "$status" -eq 0 ]  
    sleep 20
}

# starter test 8
#0 appsody operator install --namespace test --watch-all
@test "integration-operator_test8-good-path-appsody-operator-install-namespace-test-watch-all-starter" {
    # operator install --namespace test --watch-all
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator install --namespace test --watch-all -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-operator-install-namespace-test-watch-all-starter.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator install
@test "integration-operator_test8-bad-path-appsody-operator-install-starter" {
    # operator install
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator install -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-install-starter.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test8-good-path-appsody-deploy-starter" {
    # deploy
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-starter.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test
@test "integration-operator_test8-good-path-appsody-deploy-namespace-test-starter" {
    # deploy --namespace test
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-namespace-test-starter.log
    [ "$status" -eq 0 ]  
}
#0 appsody deploy --namespace test2
@test "integration-operator_test8-good-path-appsody-deploy-namespace-test2-starter" {
    # deploy --namespace test2
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY deploy --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-deploy-namespace-test2-starter.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall
@test "integration-operator_test8-bad-path-appsody-operator-uninstall-starter" {
    # operator uninstall
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-uninstall-starter.log
    [ "$status" -eq 1 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test8-bad-path-appsody-operator-uninstall-namespace-test-starter" {
    # operator uninstall --namespace test
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test8-bad-path-appsody-operator-uninstall-namespace-test-starter.log
    [ "$status" -eq 1 ]  
}
#0 appsody operator uninstall --namespace test --force
@test "integration-operator_test8-good-path-appsody-operator-uninstall--namespace-test-force-starter" {
    # operator uninstall --namespace test --force
    cd $TEMPDIR/starter
    run timeout 1h $APPSODY operator uninstall --namespace test --force -v
    echo "${output}" > $LOGDIR/integration-operator_test8-good-path-appsody-operator-uninstall-namespace-test-foce-starter.log
    [ "$status" -eq 0 ]  
    sleep 20
}
# teardown
@test "integration-operator_teardown-good-path-kubectl-delete-ns-test" {
    # delete ns test
    run timeout 1h kubectl delete ns test
    echo "${output}" > $LOGDIR/integration-operator_teardown-good-path-kubectl-delete-ns-test.log
    [ "$status" -eq 0 ]
}
@test "integration-operator_teardown-good-path-kubectl-delete-ns-test2" {
    # delete ns test2
    run timeout 1h kubectl delete ns test2
    echo "${output}" > $LOGDIR/integration-operator_teardown-good-path-kubectl-delete-ns-test2.log
    [ "$status" -eq 0 ]
}