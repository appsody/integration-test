load kim_helper
teardown() {
  if [[ "${#BATS_TEST_NAMES[@]}" -eq "$BATS_TEST_NUMBER" ]]; then
    rm -rf $GOPATH
  fi
}
# nodejs
# @test "integration-good-path-appsody-init-nodejs" {
#   # init
#   mkdir -p $TEMPDIR/nodejs
#   cd $TEMPDIR/nodejs
#   run timeout 1h $APPSODY init nodejs
#   echo "${output}" > $LOGDIR/integration-good-path-appsody-init-nodejs.log
#   [ "$status" -eq 0 ]
# }
@test "integration-good-path-appsody-run-nodejs" {
  # run
  #cd $TEMPDIR/nodejs
  #run timeout 1h $APPSODY run &

  #psoutput=$(ps -opid,pgid,command | grep "appsody run")
  #sleep 10
  echo "$psoutput" > $LOGDIR/psoutput.log
  #echo "${output}" > $LOGDIR/integration-good-path-appsody-run-nodejs.log
  [ "$status" -eq 0 ]  
}
# @test "integration-good-path-appsody-ps" {
#   # ps
#   cd $TEMPDIR/nodejs
#   run timeout 1h $APPSODY ps
#   echo "${output}" > $LOGDIR/integration-good-path-appsody-ps.log
#   [ "$status" -eq 0 ]  
# }
