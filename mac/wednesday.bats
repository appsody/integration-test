#!/usr/bin/env bats
setup() {
  if [[ "$BATS_TEST_NUMBER" -eq 1]]; then
    mkdir $HOME/bats_temp/logs/$(date +%Y%m%d_%H%M%S)
    export LOG_DIR=$HOME/bats_temp/logs/$(date +%Y%m%d_%H%M%S)
    GO_PATH=$(go env GOPATH)
    mkdir $GO_PATH/src/github.com/appsody
    export TEMP_DIR=$GOPATH/src/github.com/appsody
  fi
}
@test "test appsody list" {
  run appsody list
  echo "${output}" > $LOG_DIR/test-appsody-list.log
  echo "${output}"
  [ "$status" -eq 0 ]
}
@test "test appsody repo list" {
  run appsody repo list
  echo "${output}" > $LOG_DIR/test-appsody-repo-list.log
  echo "${output}"
  [ "$status" -eq 0 ]
}

teardown() {
  if [[ "${#BATS_TEST_NAMES[@]}" -eq "$BATS_TEST_NUMBER" ]]; then
    rm -rf $TEMP_DIR
  fi
}