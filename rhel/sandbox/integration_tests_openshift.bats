load integration_helper
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
@test "integration-good-path-appsody-init-nodejs-express" {
    # init
    mkdir -p $TEMPDIR/nodejs-express
    cd $TEMPDIR/nodejs-express
    run timeout 1h $APPSODY init -v dev.local/nodejs-express
    echo "${output}" > $LOGDIR/integration-good-path-appsody-init-nodejs-express.log
    [ "$status" -eq 0 ]
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