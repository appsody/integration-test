#!/usr/bin/env bats
@test "test appsody list" {
  run appsody list
  echo "${output}"
  [ "$status" -eq 0 ]
}