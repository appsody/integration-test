load helper
teardown() {
  if [[ "${#BATS_TEST_NAMES[@]}" -eq "$BATS_TEST_NUMBER" ]]; then
    rm -rf $GOPATH
  fi
}
@test "good path test appsody stack package nodejs" {
  cd $TEMPDIR/stacks/incubator/nodejs
  run $APPSODY stack package
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-stack-validate-nodejs.log
  [ "$status" -eq 0 ]
}
@test "good path test appsody test nodejs-express" {
  # init
  mkdir -p $TEMPDIR/nodejs
  cd $TEMPDIR/nodejs
  run $APPSODY init dev.local/nodejs-express
  #echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-init-nodejs-express.log
  [ "$status" -eq 0 ]

  # test
  run $APPSODY test
  #echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-test-nodejs-express.log
  [ "$status" -eq 0 ]  

  # deploy delete
  run $APPSODY stop
  #echo "${output}"
  echo "${output}" > $LOGDIR/bad-path-appsody-stop-nodejs-express.log
  [ "$status" -eq 1 ]  
}