load operator_helper
teardown() {
  if [[ "${#BATS_TEST_NAMES[@]}" -eq "$BATS_TEST_NUMBER" ]]; then
    rm -rf $GOPATH
  fi
}

add sleep 20 after every delete as it takes a few seconds

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
    run timeout 1h $APPSODY stack validate
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
@test "integration-operator_test2-bad-path-appsody-operator-install--namespace-test-nodejs" {
    # operator install --namespace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator install --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test2-bad-path-appsody-operator-install-namespace-test-nodejs.log
    [ "$status" -eq 1 ]  
}
#0 appsody deploy
@test "integration-operator_test2-good-path-appsody-deploy--nodejs" {
    # deploy
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-deploy-nodejs.log
    [ "$status" -eq 0 ]  
}
#1 appsody operator uninstall --namespace test
@test "integration-operator_test2-bad-path-appsody-operator-uninstall--namespace-test-nodejs" {
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
}
#0 appsody operator uninstall --force
@test "integration-operator_test2-good-path-appsody-operator-uninstall-force-nodejs" {
    # operator uninstall --force
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall --force -v
    echo "${output}" > $LOGDIR/integration-operator_test2-good-path-appsody-operator-uninstall-force-nodejs.log
    [ "$status" -eq 0 ]  
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
}
#0 appsody operator uninstall
@test "integration-operator_test3-good-path-appsody-operator-uninstall-nodejs" {
    # operator uninstall
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test3-good-path-appsody-operator-uninstall-nodejs.log
    [ "$status" -eq 0 ]  
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
}
#0 appsody operator uninstall --namespace test
@test "integration-operator_test4-good-path-appsody-operator-uninstall-namespace-test-nodejs" {
    # operator uninstall --namespace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall --namespace test -v
    echo "${output}" > $LOGDIR/integration-operator_test4-good-path-appsody-operator-uninstall-namespace-test-nodejs.log
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
}
#0 appsody operator uninstall
@test "integration-operator_test5-good-path-appsody-operator-uninstall-nodejs" {
    # operator uninstall
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall -v
    echo "${output}" > $LOGDIR/integration-operator_test5-good-path-appsody-operator-uninstall-nodejs.log
    [ "$status" -eq 0 ]  
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
#0 appsody deploy delete --namespace test2
@test "integration-operator_test6-good-path2-appsody-deploy-delete-namespace-test2-nodejs" {
    # deploy delete --namespace test2
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY deploy delete --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path2-appsody-deploy-delete-namespace-test2-nodejs.log
    [ "$status" -eq 0 ]  
}
#0 appsody operator uninstall --namespace test2
@test "integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test2-nodejs" {
    # operator uninstall --namespace test
    cd $TEMPDIR/nodejs
    run timeout 1h $APPSODY operator uninstall --namespace test2 -v
    echo "${output}" > $LOGDIR/integration-operator_test6-good-path-appsody-operator-uninstall-namespace-test2-nodejs.log
    [ "$status" -eq 0 ]  
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