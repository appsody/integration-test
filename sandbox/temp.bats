#!/usr/bin/env bats
load kim_helper

teardown() {
  if [[ "${#BATS_TEST_NAMES[@]}" -eq "$BATS_TEST_NUMBER" ]]; then
    rm -rf $GOPATH
    #rm $FILE
  fi
}
@test "temp good path test appsody version" {
  # version
  runc appsody ps > $LOGDIR/good-path-appsody-version.log
  [ "$status" -eq 0 ] 
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-version-output.log
  [ "$status" -eq 0 ]  
  [ "${lines[0]}" = "appsody 0.4.9" ]
}