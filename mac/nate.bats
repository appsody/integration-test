#!/usr/bin/env bats
load helper
setup() {
    ls -la
}
@test "test appsody list" {
  run appsody list
  echo "${output}" > $LOGDIR/test-appsody-list.log
  echo "${output}"
  [ "$status" -eq 0 ]
}
@test "test appsody repo list" {
  run appsody repo list
  echo "${output}" > $LOGDIR/test-appsody-repo-list.log
  echo "${output}"
  [ "$status" -eq 0 ]
}
teardown() {
    ls -la
}