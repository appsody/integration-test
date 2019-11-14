#!/usr/bin/env bats
load helper
@test "test appsody list" {
  run $APPSODY list
  echo "${output}" > $LOGDIR/test-appsody-list.log
  echo "${output}"
  [ "$status" -eq 0 ]
}
@test "test appsody repo list" {
  run $APPSODY repo list
  echo "${output}" > $LOGDIR/test-appsody-repo-list.log
  echo "${output}"
  [ "$status" -eq 0 ]
}

teardown() {
  if [[ "${#BATS_TEST_NAMES[@]}" -eq "$BATS_TEST_NUMBER" ]]; then
    rm -rf $GOPATH
  fi
}