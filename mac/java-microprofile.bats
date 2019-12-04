load gold_mac_helper
teardown() {
  if [[ "${#BATS_TEST_NAMES[@]}" -eq "$BATS_TEST_NUMBER" ]]; then
    rm -rf $GOPATH
  fi
}
@test "good path test appsody stack validate java-microprofile" {
  #skip
  cd $TEMPDIR/stacks/incubator/java-microprofile
  run $APPSODY stack validate
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-stack-validate-java-microprofile.log
  [ "$status" -eq 0 ]
}
@test "good path test appsody deploy java-microprofile" {
  #skip
  # init
  mkdir -p $TEMPDIR/java-microprofile
  cd $TEMPDIR/java-microprofile
  run $APPSODY init dev.local/java-microprofile
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-init-java-microprofile.log
  [ "$status" -eq 0 ]

  # deploy
  run $APPSODY deploy
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-deploy-java-microprofile.log
  [ "$status" -eq 0 ]  

  # deploy delete
  run $APPSODY deploy delete
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-deploy-delete-java-microprofile.log
  [ "$status" -eq 0 ]  
}